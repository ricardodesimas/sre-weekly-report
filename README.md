# sre-weekly-report

A Claude Code plugin that documents completed tasks as feature notes and weekly report bullets.

## What it does

When you finish a task, invoke `/document-completed-task` and Claude will:

1. Create a feature notes file (`<NOTES_DIR>/features/<slug>.md`) with context, what was done, how to test, and how to revert.
2. Append a plain-text bullet to the current week's report file (`<NOTES_DIR>/weekly/<week>.md`).

The weekly file is designed to be piped through `md2slack` for pasting into Slack.

## Installation

```
/plugin install github:ricardodesimas/sre-weekly-report
```

## Configuration

Set `NOTES_DIR` in your shell to control where files are saved. Defaults to `~/Documents/work`.

```bash
# ~/.zshrc or ~/.bashrc
export NOTES_DIR="$HOME/Documents/work"
```

## Usage

After completing a task, run:

```
/document-completed-task
```

Claude will gather context from the conversation and write both files automatically.
