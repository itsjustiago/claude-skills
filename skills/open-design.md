# open-design
**Source:** https://github.com/nexu-io/open-design
**Type:** Standalone skill bundle (manually installed to ~/.claude/skills/)
**Install:** Sparse-clone the repo, copy each `skills/<name>/` to `~/.claude/skills/<name>/`. License Apache-2.0.

## What it does
Local-first, open-source alternative to Anthropic's Claude Design. Ships **74 skill bundles** that turn any prompt into a layout-appropriate prototype, deck, mobile screen, dashboard, poster, or video frame in a chosen design language. The skills coexist with the user's existing `taste-skill`, `frontend-design`, `impeccable` set — they slot in as scenario-specific skills you can invoke by name.

The Open Design app itself (Next.js + Express daemon) is not installed here — only the **skill markdown files**, which Claude Code can invoke directly via the `Skill` tool.

## Skill catalog (74 skills)

### Web prototypes
- **web-prototype** — generic desktop web prototype (default)
- **web-prototype-taste-soft** — Apple-tier soft web prototype
- **web-prototype-taste-editorial** — editorial-minimalist
- **web-prototype-taste-brutalist** — Swiss industrial-print
- **saas-landing** — single-page SaaS landing
- **dashboard** — admin / analytics with sidebar + KPI grid
- **pricing-page** — standalone pricing
- **docs-page** — documentation page (inline TOC)
- **blog-post** — long-form article
- **waitlist-page** — minimal pre-launch
- **dating-web** — consumer dating / community vibe

### Mobile
- **mobile-app** — single mobile-app screen
- **mobile-onboarding** — multi-screen onboarding flow
- **gamified-app** — multi-frame gamified mobile

### Decks (HTML PPT)
- **simple-deck** — single-file horizontal swipe (default deck)
- **html-ppt** — HTML PPT Studio shell
- **html-ppt-pitch-deck** — investor-ready 10-slide
- **html-ppt-product-launch** — launch keynote, dark mode
- **html-ppt-tech-sharing** — conference / internal tech share
- **html-ppt-weekly-report** — team weekly status
- **html-ppt-course-module** — online course / workshop module
- **html-ppt-presenter-mode-reveal** — presenter-mode tokyo-night style
- **html-ppt-taste-brutalist** — tactical-print 16:9
- **html-ppt-taste-editorial** — editorial 16:9
- **html-ppt-knowledge-arch-blueprint** — cream-blueprint architecture
- **html-ppt-graphify-dark-graph** — dark knowledge-graph deck
- **html-ppt-hermes-cyber-terminal** — dark terminal honest-review
- **html-ppt-obsidian-claude-gradient** — GitHub-purple gradient
- **html-ppt-dir-key-nav-minimal** — 8-page minimal keynote
- **html-ppt-testing-safety-alert** — red-amber 45° caution deck
- **html-ppt-xhs-pastel-card** — soft macaron lifestyle
- **html-ppt-xhs-post** — Xiaohongshu / Instagram 9-page
- **html-ppt-xhs-white-editorial** — white-bg magazine
- **guizang-ppt** — "electronic magazine × e-ink" style (default deck mode)
- **kami-deck** — print-grade slide
- **kami-landing** — print-grade single-page
- **replit-deck** — single-file horizontal swipe (Replit demo)
- **weekly-update** — single-file horizontal swipe report
- **open-design-landing** / **open-design-landing-deck** — meta brand pages
- **pptx-html-fidelity-audit** — audit a python-pptx export

### Documents / templates
- **email-marketing** — brand product-launch email
- **finance-report** — quarterly / monthly financials
- **meeting-notes** — title + agenda + decisions
- **invoice** — printable invoice
- **digital-eguide** — two-spread e-guide
- **eng-runbook** — engineering runbook
- **hr-onboarding** — new-hire onboarding plan
- **pm-spec** — product spec / PRD
- **team-okrs** — OKR tracker page
- **kanban-board** — Kanban / task board
- **wireframe-sketch** — hand-drawn wireframe
- **design-brief** — parse a structured design brief
- **flowai-live-dashboard-template** — team-management dashboard template
- **social-media-matrix-tracker-template** — social matrix tracker
- **live-dashboard** — Notion-style team dashboard
- **live-artifact** — refreshable, auditable artifact

### Posters / social
- **magazine-poster** — editorial-style poster
- **image-poster** — single-image generation skill
- **social-carousel** — three-card social-media carousel
- **social-media-dashboard** — creator-facing dashboard

### Briefings (Orbit)
- **orbit-general**, **orbit-github**, **orbit-gmail**, **orbit-linear**, **orbit-notion** — Open Orbit briefing skills

### Media (require Open Design daemon for full execution)
- **audio-jingle** — audio generation (uses `od` CLI)
- **video-shortform** — short-form video (uses `od` CLI)
- **motion-frames** — single-frame motion design
- **sprite-animation** — pixel / sprite animation
- **hyperframes** — video compositions

### Meta
- **critique** — 5-dimension expert design critique
- **tweaks** — wrap any HTML artifact with quick tweaks
- **hatch-pet** — create / repair / validate / preview component
- **html-ppt** — orchestrator for any html-ppt skill

## How to use
Once installed, every skill above is callable by name via the `Skill` tool. Examples:

> *"Use the `mobile-app` skill to build the workout home screen."*
> *"Run the `critique` skill on this design."*
> *"Make a pitch deck — use `html-ppt-pitch-deck`."*

Pair with a design system (the user's existing `taste-skill` variants — soft/editorial/brutalist — work as the visual language layer):

> *"Use `mobile-app` skill with `soft-skill` aesthetic."*

## What's NOT installed
- The **Open Design Next.js + daemon app** (the GUI). Only skill markdown files are installed; full app would require `pnpm install` + the daemon process. Skills that call `od` CLI (audio-jingle, video-shortform, hyperframes, sprite-animation, motion-frames, live-artifact, live-dashboard, flowai-live-dashboard-template) will not generate media — they'll instead fall back to descriptive HTML output unless the daemon is running.
- The **139 design systems** from `design-systems/`. They are preserved for reference at `~/.claude/skills-source/open-design/design-systems/` but not invoked as skills (they are CSS / token bundles meant for the Open Design app to consume).

## Reinstall / update

```bash
# Sparse-clone latest open-design
git clone --depth 1 --filter=blob:none --sparse https://github.com/nexu-io/open-design.git /tmp/open-design
cd /tmp/open-design
git sparse-checkout set skills design-systems

# Copy skills to ~/.claude/skills/ (no overwrite policy: rm -rf first if you want clean upgrade)
cp -r skills/* ~/.claude/skills/

# (Optional) refresh design systems source mirror
mkdir -p ~/.claude/skills-source/open-design
cp -r design-systems ~/.claude/skills-source/open-design/
cp -r skills ~/.claude/skills-source/open-design/
```

The bundled `setup/install-plugins.sh` does this automatically as part of the post-plugin manual-install block.
