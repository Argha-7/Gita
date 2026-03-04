#!/bin/sh

# Set the home directory for NullClaw
# Hugging Face usually provides a HOME env var, but we'll make sure it's set
export NULLCLAW_HOME=${HOME:-/home/nullclaw}
mkdir -p "$NULLCLAW_HOME"

# Create a basic config.json from environment variables
# This allows the user to set secrets in Hugging Face Space settings
cat <<EOF > "$NULLCLAW_HOME/config.json"
{
  "models": {
    "providers": {
      "${NULLCLAW_PROVIDER:-openrouter}": {
        "api_key": "${API_KEY:-sk-...}"
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "${NULLCLAW_PROVIDER:-openrouter}/${NULLCLAW_MODEL:-anthropic/claude-3-5-sonnet}"
      },
      "api_key": "${API_KEY}",
      "default_provider": "${NULLCLAW_PROVIDER:-openai}",
      "default_model": "${NULLCLAW_MODEL:-llama-3.3-70b-versatile}",
      "default_temperature": 0.7,
      "base_url": "${NULLCLAW_BASE_URL:-https://api.groq.com/openai/v1}"
    }
  },
  "channels": {
    "telegram": {
      "accounts": {
        "main": {
          "bot_token": "${TELEGRAM_BOT_TOKEN}",
          "allow_from": ["*"],
          "reply_in_private": true
        }
      }
    }
  },
  "http_request": {
    "enabled": ${WEB_SEARCH_ENABLED:-false},
    "search_provider": "${WEB_SEARCH_PROVIDER:-duckduckgo}",
    "search_base_url": "${WEB_SEARCH_URL:-}"
  },
  "composio": {
    "api_key": "${COMPOSIO_API_KEY:-}"
  },
  "gateway": {
    "port": ${PORT:-7860},
    "allow_public_bind": true
  }
}
EOF

echo "Starting NullClaw Gateway on port ${PORT:-7860}..."
exec nullclaw gateway --port "${PORT:-7860}"
