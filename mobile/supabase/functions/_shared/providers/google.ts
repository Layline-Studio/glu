import {
  AiInvalidResponseError,
  AiProviderError,
  AiRetryableProviderError,
} from "../ai_errors.ts";
import type { RequestOptions } from "../request_options.ts";

async function sleep(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function withRetry(
  url: string,
  options: RequestInit,
  maxRetries = 5,
): Promise<Response> {
  let lastError: AiRetryableProviderError | null = null;

  for (let attempt = 0; attempt < maxRetries; attempt++) {
    const response = await fetch(url, options);

    if (response.ok) {
      return response;
    }

    if (response.status !== 429 && response.status !== 503) {
      return response;
    }

    const text = await response.text();
    lastError = new AiRetryableProviderError(
      "google",
      `Google error: ${text}`,
      response.status,
    );

    const backoffMs = Math.pow(2, attempt) * 1000;
    await sleep(backoffMs);
  }

  throw (
    lastError ??
      new AiRetryableProviderError("google", "Google max retries exceeded", 429)
  );
}

export type GoogleUsage = {
  model: string;
  inputTokens: number;
  outputTokens: number;
  promptCacheReadTokens?: number;
};

export type GoogleResult<T> = {
  result: T;
  usage: GoogleUsage;
};

export async function callGoogleWithUsage<T>(
  systemPrompt: string,
  options: RequestOptions & {
    schema: Record<string, unknown>;
  },
): Promise<GoogleResult<T>> {
  const apiKey = Deno.env.get("GOOGLE_API_KEY") ??
    Deno.env.get("GEMINI_API_KEY");
  if (!apiKey) {
    throw new AiProviderError(
      "google",
      "Missing GOOGLE_API_KEY (or GEMINI_API_KEY)",
    );
  }

  const REQUEST_TIMEOUT_MS = 300_000;
  const model = "gemini-2.5-flash-lite";
  // const model = "gemini-3-flash-preview";
  const thinkingConfig = { thinkingBudget: 0 };
  const attachments = options.attachments?.filter(Boolean) ?? [];
  const allowedAttachmentTypes = new Set([
    "image/png",
    "image/jpeg",
    "image/jpg",
    "image/webp",
    "image/heic",
    "image/heif",
    "audio/m4a",
    "audio/mp4",
    "audio/aac",
    "audio/mpeg",
    "audio/mp3",
    "audio/wav",
    "audio/webm",
    "audio/ogg",
  ]);

  for (const attachment of attachments) {
    const mimeType = attachment.mimeType?.toLowerCase().trim();
    if (!mimeType || !attachment.dataBase64?.trim()) {
      throw new AiProviderError(
        "google",
        "Attachment missing mimeType or dataBase64",
      );
    }
    if (!allowedAttachmentTypes.has(mimeType)) {
      throw new AiProviderError(
        "google",
        `Unsupported attachment mimeType: ${mimeType}`,
      );
    }
  }

  const validationFeedback = options.validationFeedback ?? [];
  const validationBlock = validationFeedback.length > 0
    ? [
      "CRITICAL VALIDATION FAILURES FROM YOUR PREVIOUS INVALID RESPONSE:",
      ...validationFeedback.map(
        (message, index) => `${index + 1}. ${message}`,
      ),
      "Return valid JSON that fixes every listed issue.",
    ].join("\n")
    : "";
  const promptText = [options.userPrompt ?? "", validationBlock]
    .filter((part) => part.trim().length > 0)
    .join("\n\n");

  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);

  try {
    const response = await withRetry(
      `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        signal: controller.signal,
        body: JSON.stringify({
          system_instruction: { parts: [{ text: systemPrompt }] },
          contents: [
            {
              parts: [
                ...attachments.map((attachment) => ({
                  inline_data: {
                    mime_type: attachment.mimeType,
                    data: attachment.dataBase64,
                  },
                })),
                ...(attachments.length > 0
                  ? [
                    {
                      text: options.attachmentInstructionText?.trim() ||
                        "Analyze each attachment in full before answering.",
                    },
                  ]
                  : []),
                { text: promptText },
              ],
            },
          ],
          generationConfig: {
            response_mime_type: "application/json",
            response_schema: options.schema,
            thinkingConfig,
          },
        }),
      },
    );

    if (!response.ok) {
      const text = await response.text();
      const retryable = response.status === 429 ||
        response.status === 503 ||
        response.status >= 500;
      if (retryable) {
        throw new AiRetryableProviderError(
          "google",
          `Google error: ${text}`,
          response.status,
        );
      }
      throw new AiProviderError(
        "google",
        `Google error: ${text}`,
        response.status,
      );
    }

    type GoogleResponseData = {
      candidates?: Array<{ content?: { parts?: Array<{ text?: string }> } }>;
      usageMetadata?: {
        promptTokenCount?: number;
        candidatesTokenCount?: number;
        cachedContentTokenCount?: number;
      };
    };

    const data = (await response.json()) as GoogleResponseData;
    const text = (data?.candidates?.[0]?.content?.parts ?? [])
      .map((part) => part.text)
      .filter(
        (partText): partText is string =>
          typeof partText === "string" && partText.length > 0,
      )
      .join("");

    if (!text) {
      throw new AiInvalidResponseError(
        "google",
        `Google response missing text: ${JSON.stringify(data).slice(0, 2000)}`,
      );
    }

    try {
      return {
        result: JSON.parse(text) as T,
        usage: {
          model,
          inputTokens: data?.usageMetadata?.promptTokenCount ?? 0,
          outputTokens: data?.usageMetadata?.candidatesTokenCount ?? 0,
          promptCacheReadTokens: toPositiveInt(
            data?.usageMetadata?.cachedContentTokenCount,
          ),
        },
      };
    } catch (error) {
      throw new AiInvalidResponseError(
        "google",
        `Invalid JSON from Google: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
    }
  } catch (error) {
    if (error instanceof DOMException && error.name === "AbortError") {
      throw new AiRetryableProviderError(
        "google",
        `Google request timed out after ${REQUEST_TIMEOUT_MS}ms`,
        408,
      );
    }
    throw error;
  } finally {
    clearTimeout(timeoutId);
  }
}

function toPositiveInt(value: unknown): number | undefined {
  if (typeof value !== "number" || !Number.isFinite(value)) {
    return undefined;
  }
  const rounded = Math.floor(value);
  return rounded > 0 ? rounded : undefined;
}
