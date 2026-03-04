# Deploying NullClaw to Hugging Face Spaces (24/7)

Hugging Face Spaces (Docker SDK) is a great way to run NullClaw 24/7 for free.

## Prerequisites (Taiyari)

Sabse pehle aapko ye 3 cheezein chahiye:

1. **Telegram Bot Token:**
    * Telegram par `@BotFather` search karein aur use `/newbot` command dein.
    * Apne bot ka naam aur username set karein.
    * Aapko ek `HTTP API Token` milega (jaise `123456:ABC-DEF`). Ise save kar lein.

2. **LLM API Key:**
    * [OpenRouter](https://openrouter.ai/) ya [Anthropic](https://console.anthropic.com/) se apni API key lein.

3. **Composio API Key (Instagram ke liye):**
    * [Composio.dev](https://composio.dev/) par account banakar apni API key lein aur Instagram connect karein.

## Steps to Deploy

        * `NULLCLAW_PROVIDER`: `openai` (Groq OpenAI compatible hai).
        * `NULLCLAW_MODEL`: `llama-3.3-70b-versatile` (ya koi aur Groq model).
        * `NULLCLAW_BASE_URL`: `https://api.groq.com/openai/v1`
        * `WEB_SEARCH_ENABLED`: `true` (to enable web search).
        * `WEB_SEARCH_PROVIDER`: `duckduckgo` (no API key needed) or `tavily`, `google`, etc.
        * `COMPOSIO_API_KEY`: Instagram/Social Media automation ke liye (Composio.dev se milti hai).

4. **Wait for Build:**
    * Check the **Logs** tab to ensure the build completes and the gateway starts.

## Important Note on Memory

The free tier is ephemeral. Your assistant's memory will reset on restart unless you use Hugging Face's persistent storage.
