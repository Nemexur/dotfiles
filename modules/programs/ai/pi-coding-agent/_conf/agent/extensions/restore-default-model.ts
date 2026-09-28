import {
  getAgentDir,
  SettingsManager,
  type ExtensionAPI,
  type ExtensionContext,
} from "@earendil-works/pi-coding-agent";

const DEFAULT_PROVIDER = "anthropic";
const DEFAULT_MODEL = "claude-opus-4-8";
const EXTENSION_NAME = "restore-default-model";

function isDefaultModel(model: ExtensionContext["model"]): boolean {
  return (
    model?.provider === DEFAULT_PROVIDER &&
    model.id === DEFAULT_MODEL
  );
}

function formatError(error: unknown): string {
  return error instanceof Error ? error.message : String(error);
}

function reportError(ctx: ExtensionContext, message: string): void {
  const formatted = `[${EXTENSION_NAME}] ${message}`;

  if (ctx.hasUI) {
    ctx.ui.notify(formatted, "error");
  } else {
    console.error(formatted);
  }
}

async function persistDefaultModel(ctx: ExtensionContext): Promise<void> {
  try {
    // A fresh manager avoids retaining stale parse errors or settings state.
    const settings = SettingsManager.create(ctx.cwd, getAgentDir());

    settings.setDefaultModelAndProvider(
      DEFAULT_PROVIDER,
      DEFAULT_MODEL,
    );

    await settings.flush();

    const errors = settings.drainErrors();
    if (errors.length === 0) return;

    reportError(
      ctx,
      errors
        .map(({ scope, error }) => `${scope}: ${error.message}`)
        .join("; "),
    );
  } catch (error) {
    reportError(
      ctx,
      `Failed to persist the default model: ${formatError(error)}`,
    );
  }
}

export default function restoreDefaultModel(pi: ExtensionAPI): void {
  /*
   * Pi persists every model selection. Restore the configured default
   * immediately after each selection, while leaving the selected model
   * active for the current session.
   */
  pi.on("model_select", async (_event, ctx) => {
    await persistDefaultModel(ctx);
  });

  pi.on("session_start", async (_event, ctx) => {
    const model = ctx.modelRegistry.find(
      DEFAULT_PROVIDER,
      DEFAULT_MODEL,
    );

    if (!model) {
      reportError(
        ctx,
        `Model ${DEFAULT_PROVIDER}/${DEFAULT_MODEL} is not registered`,
      );
      return;
    }

    if (isDefaultModel(ctx.model)) {
      // The active model is correct, but settings.json might not be.
      await persistDefaultModel(ctx);
      return;
    }

    try {
      const selected = await pi.setModel(model);

      if (!selected) {
        reportError(
          ctx,
          `Authentication is not configured for ${DEFAULT_PROVIDER}/${DEFAULT_MODEL}`,
        );
      }
    } catch (error) {
      reportError(
        ctx,
        `Failed to select ${DEFAULT_PROVIDER}/${DEFAULT_MODEL}: ${formatError(error)}`,
      );
    }
  });
}
