# claude-video (`/watch`)
**Source:** https://github.com/bradautomates/claude-video
**Type:** Plugin
**Install:** `claude plugin marketplace add bradautomates/claude-video && claude plugin install watch@claude-video --scope user`

## What it does
Gives Claude the ability to actually *watch* a video. You paste a URL (anything `yt-dlp` supports — YouTube, TikTok, Loom, X, Instagram, Vimeo, plus a few hundred more) or a local path (`.mp4`, `.mov`, `.mkv`, `.webm`), ask a question, and Claude downloads it, extracts frames at an auto-scaled rate, pulls a timestamped transcript, and `Read`s every frame as an image. By the time it answers, it has seen the video and heard the audio — not guessed from the title or description.

Captions cover most public videos for free. Whisper API key is only needed when a video has no caption track (typical for local files, TikToks, some Vimeos).

## Trigger phrase
`/watch <url-or-path> <question>`

```
/watch https://youtu.be/dQw4w9WgXcQ what happens at the 30 second mark?
/watch https://www.tiktok.com/@user/video/123 summarize this
/watch ~/Movies/screen-recording.mp4 when does the UI break?
/watch https://vimeo.com/123 what tools does she mention?
```

Focused mode (denser frames on a specific window, lower token cost):
```
/watch https://youtu.be/abc --start 2:15 --end 2:45
/watch video.mp4 --start 50 --end 60
```

## How it works
1. **`yt-dlp` downloads** (URLs only — local files probed in place).
2. **`ffmpeg` extracts frames** at a duration-aware budget: ≤30 s → ~30 frames, 1–3 min → ~60, 3–10 min → ~80, longer → 100 sparsely. Hard caps: 2 fps, 100 frames. JPEGs at 512 px (bump with `--resolution 1024` for on-screen text).
3. **Transcript**: native captions first (free, instant), Whisper fallback (Groq `whisper-large-v3` preferred, OpenAI `whisper-1` alt) if none.
4. **Frames + transcript handed to Claude** with `t=MM:SS` markers. Claude `Read`s frames in parallel — JPEGs render directly as images in context.

## Knobs (passed to `scripts/watch.py`)
- `--start` / `--end` — focus on a window (denser per-second budget)
- `--max-frames N` — lower the cap for tighter token budget
- `--resolution W` — bump to 1024 px for slides/terminals/code
- `--fps F` — override auto-fps (still capped at 2 fps)
- `--whisper groq|openai` — force a backend
- `--no-whisper` — frames only, no transcription
- `--out-dir DIR` — keep working files somewhere specific

## What people use it for
- **Analyze someone else's content** — viral hook breakdowns, ad creative, podcast intros, competitor launches
- **Diagnose bugs from screen recordings** — Claude finds the frame where the issue appears
- **Summarize long videos** — pull the structure and key moments faster than 2x playback

## Bring your own keys (optional)
| Capability | What you need | Cost |
|---|---|---|
| Download + native captions | `yt-dlp` + `ffmpeg` | Free |
| Whisper fallback (preferred) | [Groq API key](https://console.groq.com/keys) | Cheap, fast |
| Whisper fallback (alt) | [OpenAI API key](https://platform.openai.com/api-keys) | Standard |
| Disable Whisper | `--no-whisper` | Free, frames only |

Stored in `~/.config/watch/.env` (mode `0600`, scaffolded on first run).

## First-run setup
The first `/watch` call runs `scripts/setup.py --check`. If `ffmpeg` / `yt-dlp` aren't on PATH, it walks you through:
- **macOS** — auto-runs `brew install ffmpeg yt-dlp`
- **Linux** — prints exact `apt` / `dnf` / `pipx` commands
- **Windows** — prints `winget` / `pip` commands

After setup, preflight is a sub-100 ms lookup.

## Limits
- **Best accuracy: under 10 minutes.** Longer triggers a "sparse scan" warning — re-run focused.
- **Hard caps: 2 fps, 100 frames.** Frame count drives token cost.
- **Whisper upload limit: 25 MB** (≈50 min mono 16 kHz audio).
- **No private platforms.** Public URLs and local files only — no auth.
