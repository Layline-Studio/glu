export type AiProviderName = "google";

export class AiProviderError extends Error {
  constructor(
    public provider: AiProviderName,
    message: string,
    public status?: number,
  ) {
    super(message);
    this.name = "AiProviderError";
  }
}

export class AiRetryableProviderError extends AiProviderError {
  constructor(
    provider: AiProviderName,
    message: string,
    status?: number,
  ) {
    super(provider, message, status);
    this.name = "AiRetryableProviderError";
  }
}

export class AiInvalidResponseError extends Error {
  constructor(public provider: AiProviderName, message: string) {
    super(message);
    this.name = "AiInvalidResponseError";
  }
}
