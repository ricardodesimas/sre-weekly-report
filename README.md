# sre-weekly-report

A Claude Code plugin that documents completed tasks as feature notes and weekly report bullets.

## What it does

When you finish a task, invoke `/document-completed-task` and Claude will:

1. Create a feature notes file (`<NOTES_DIR>/features/<slug>.md`) with context, what was done, how to test, and how to revert.
2. Append a plain-text bullet to the current week's report file (`<NOTES_DIR>/weekly/<week>.md`).

The weekly file is designed to be piped through `md2slack` for pasting into Slack.

## Installation

**1. Install the plugin:**

```
/plugin install github:ricardodesimas/sre-weekly-report
```

**2. Add `md2slack` to your shell:**

```bash
echo 'source ~/path/to/sre-weekly-report/shell/md2slack.sh' >> ~/.zshrc
source ~/.zshrc
```

Or copy the function directly into your `~/.zshrc`:

```bash
md2slack() {
  sed -E 's/\*\*//g; s/__//g; s/\*//g; s/`//g; s/^#+[[:space:]]*//' | grep -v '^[[:space:]]*$'
}
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

To copy the weekly report to Slack:

```bash
cat $NOTES_DIR/weekly/<week>.md | md2slack | pbcopy
```
