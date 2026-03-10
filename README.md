# Gemini Skills for Claude Code

Two Claude Code skills that bring Gemini's unique capabilities — **real-time web search** and **image generation** — directly into your Claude Code workflow.

## Skills

### `/gemini-research` — Real-time Web Search
Uses Gemini to research any topic with live internet access. Results are output verbatim — Claude does not summarize or modify them.

```
/gemini-research 2026年最新 AI 模型发布
/gemini-research latest React state management trends --save ~/Desktop/research.md
```

### `/gemini-image` — Image Generation
Generates images and automatically saves them as local files. Returns the file path.

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
- A `GEMINI_API_KEY` set in your shell profile

## Installation

```bash
git clone https://github.com/zane98/gemini-skills.git
cd gemini-skills
bash install.sh
```

## Configuration

The skills read two environment variables from your shell profile (`~/.zshrc` or `~/.bashrc`):

| Variable | Required | Description |
|---|---|---|
| `GEMINI_API_KEY` | ✅ Yes | Your API key |
| `GEMINI_BASE_URL` | Optional | API base URL. Defaults to the official Google endpoint |

### Option 1: Official Google Gemini API (Recommended)

Get a free API key from [Google AI Studio](https://aistudio.google.com/), then add to `~/.zshrc`:

```bash
export GEMINI_API_KEY="AIza..."
# GEMINI_BASE_URL not needed — official endpoint is used by default
```

### Option 2: Third-party / Self-hosted OpenAI-compatible Endpoint

Any OpenAI-compatible API that serves Gemini models is supported. Set both variables:

```bash
export GEMINI_API_KEY="sk-your-key"
export GEMINI_BASE_URL="https://your-proxy.example.com/v1"
```

> **Note:** When using a third-party proxy, the available model names may differ. Edit the `model` field inside the SKILL.md files to match what your provider supports.

## Customization

Skills are plain markdown files. After installing, edit them directly:

```
~/.claude/skills/gemini-research/SKILL.md  — change model, system prompt, or timeout
~/.claude/skills/gemini-image/SKILL.md     — change default size or save directory
```

## How It Works

These skills call the Gemini API directly via Python's built-in `urllib` — no extra dependencies needed. Claude Code runs the API call as a shell script, then handles the result: writing raw text output to a file, or decoding base64 image data and saving it locally.
