# Mastery — Agent Skill Manager

> Think Final Fantasy Ascension Grid meets your `~/.claude/skills` directory.

Mastery is a desktop app for browsing, enabling, and discovering AI agent skills. It gives you an interactive skill tree to visualize and manage skills for [Claude Code](https://claude.ai/code) and other AI agents.

![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Windows%20%7C%20Linux-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## Download

Grab the latest release for your platform:

| Platform | File |
|----------|------|
| **macOS** (Apple Silicon + Intel) | `.dmg` |
| **Windows** | `.exe` (NSIS installer) |
| **Linux** | `.AppImage` |

👉 **[Go to Releases →](https://github.com/luccast/mastery-releases/releases/latest)**

> macOS users: if you see a security warning, right-click the `.dmg` and choose **Open**.

## What it does

- **Skill Tree** — visualizes your installed skills as a radial 2D graph. Each provider has its own branch; skills fan out from their hub. Navigate with WASD, zoom with scroll, click any node to inspect it.
- **Focus mode** — click a skill to trace its full dependency path from the center outward. Cycle through siblings and providers with the keyboard.
- **Enable / Disable** — toggle individual skills or an entire provider's suite on or off without uninstalling.
- **Explore** — browse the public skill registry, search by name or category, and install new skills directly from the UI.
- **Character Select** — choose your active AI agent (Claude Code, with more coming).

## Skill Providers

Mastery currently supports the following skill registries:

- **[skills.sh](https://skills.sh)** — browse and install community skills directly from the Explore tab

More providers coming soon.

## Requirements

- Skills installed under `~/.claude/skills/` or `~/.agents/skills/`  
  (via [`npx skills`](https://github.com/anthropics/skills) or manually)
- No Node.js or terminal required — the app is fully self-contained.

## Navigation

| Input | Action |
|-------|--------|
| `WASD` / Arrow keys | Pan the skill tree |
| Scroll | Zoom in / out |
| Click node | Enter focus mode |
| `H` / `L` or `←` / `→` | Cycle siblings in focus mode |
| `Esc` | Exit focus mode / open menu |
| `Shift` (hold) | Reveal token consumption view |

## Auto-updates

Mastery checks for new releases automatically on startup and will prompt you to update when one is available.

## License

© 2026 Luciano Castillo. All rights reserved.
