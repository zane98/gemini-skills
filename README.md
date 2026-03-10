# Claude Gemini Skills

Two Claude Code skills that bring Gemini's unique capabilities — **real-time web search** and **image generation** — directly into your Claude Code workflow.

## Skills

### `/gemini-research` — Real-time Web Search
Uses Gemini Pro Search to research any topic with live internet access. Results are output verbatim without Claude summarizing or modifying them.

```
/gemini-research 2026年最新 AI 模型发布
/gemini-research latest React state management trends --save ~/Desktop/research.md
```

### `/gemini-image` — Image Generation
Generates images and automatically saves them to a local file. Returns the file path.

```
/gemini-image a cat reading a book in a cozy library, Studio Ghibli style
/gemini-image product mockup, minimal design --size 512x512
/gemini-image landscape wallpaper --size 4096x4096 --dir ~/Desktop
```

**Parameters:**
- `--size` — Image dimensions (e.g. `512x512`, `1024x1024`, `4096x4096`). Default: `1024x1024`
- `--dir` — Save directory. Default: `~/Pictures/gemini-images`

## Requirements

- [Claude Code](https://claude.ai/code) CLI installed
- A Gemini-compatible API key (OpenAI-format, `sk-...`)
  - Official: [Google AI Studio](https://aistudio.google.com/) — get an `AIza...` key and use with the official endpoint
  - Or any OpenAI-compatible Gemini proxy

## Installation

```bash
git clone https://github.com/zane98/claude-gemini-skills.git
cd claude-gemini-skills
bash install.sh
```

Then add your API credentials to `~/.zshrc` (or `~/.bashrc`):

```bash
export GEMINI_API_KEY="your-api-key-here"

# Only needed if using a custom endpoint (not required for official Google API)
# export GEMINI_BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai"
```

Restart Claude Code, and the skills are ready.

## Using the Official Google Gemini API

If you want to use Google's official API instead of a third-party proxy:

1. Get an API key from [Google AI Studio](https://aistudio.google.com/)
2. Set the endpoint in `~/.zshrc`:
   ```bash
   export GEMINI_API_KEY="AIza..."
   export GEMINI_BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai"
   ```
3. Update the model names in the SKILL.md files if needed (e.g. `gemini-2.0-flash`, `gemini-1.5-pro`)

## Customization

Skills are plain markdown files in `~/.claude/skills/`. You can edit them directly:

- `~/.claude/skills/gemini-research/SKILL.md` — change the system prompt, model, or timeout
- `~/.claude/skills/gemini-image/SKILL.md` — change the default size or save directory

## How It Works

These skills call the Gemini API directly via Python's `urllib` (no extra dependencies). Claude Code executes the API call, then handles saving the result — either writing raw text output or decoding base64 image data to a local file.
