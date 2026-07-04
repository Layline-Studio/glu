export type AttachmentPayload = {
  mimeType: string;
  dataBase64: string;
};

export type RequestOptions = {
  userPrompt?: string;
  attachments?: AttachmentPayload[];
  attachmentInstructionText?: string;
  schema?: Record<string, unknown>;
  validationFeedback?: string[];
};
