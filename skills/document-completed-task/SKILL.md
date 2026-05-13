---
name: document-completed-task
description: Use when a task, feature, or fix has just been completed and needs to be documented — creates a feature notes file and appends a bullet point to the current week's report.
---

# Document Completed Task

## Overview

When a task is done, write a feature notes file and update the weekly report.

The base directory is controlled by the `NOTES_DIR` environment variable. If not set, defaults to `~/Documents/work`. Users configure it once in their shell:

```bash
# ~/.zshrc or ~/.bashrc
export NOTES_DIR="$HOME/Documents/work"
```

## Steps

### 1. Resolve the notes directory

```bash
echo "${NOTES_DIR:-$HOME/Documents/work}"
```

Use the result as `<base>` in all paths below.

### 2. Gather context

Collect from the conversation (do NOT ask if already known):
- Feature/task name (short, slug-friendly)
- JIRA ticket(s)
- Branch name
- What was done (2–4 sentences)
- Why it was done (the problem it solved)
- How to test / verify
- How to revert if needed (optional but include if relevant)

### 3. Create the feature notes file

File: `<base>/features/<slug>.md`

Use this template:

```markdown
# <Title>

**Date:** <YYYY-MM-DD>
**JIRA:** <ticket(s)>
**Branch:** `<branch>`
**Project:** `<infra/service/...>`

## Context

<Background — what existed before and why it mattered>

## Problem

<What was broken or missing>

## What was done

<What changed and how — bullet points or prose, whatever fits best>

## How to test

<curl commands, console checks, or manual steps>

## How to revert (if applicable)

<Commands or steps to undo>
```

### 4. Append to the weekly file

Weeks reset on Wednesday. Determine the correct week number with:
```bash
dow=$(date +%u)
if [ "$dow" -lt 3 ]; then
  offset=$((dow - 3 + 7))
  week=$(date -v -${offset}d +%V)
else
  week=$(date +%V)
fi
echo $week
```

Mon/Tue roll back to the previous Wednesday's week; Wed–Sun use the current week.

File: `<base>/weekly/<week>.md`

- If the file does not exist, create it with a `# Week <N> — <date range>` heading first.
- Append a single bullet point in plain English. No markdown bold or formatting.

Bullet format:
```
- <Feature name> (<JIRA>): <One sentence on what changed and why.>
```

## Example

Feature notes file → `<base>/features/p4-cloudwatch-log-groups.md`

Weekly bullet appended to `<base>/weekly/20.md`:
```
- P4 pipeline CloudWatch log groups (SRE-7251): Declared explicit log groups with 14-day retention for all p4 Lambda functions and CodeBuild projects, replacing AWS auto-created groups with no retention policy.
```

## Notes

- Slug the feature name: lowercase, hyphens, no spaces (e.g. `cloudfront-caching`, `p4-log-groups`)
- If a feature notes file for this topic already exists, update it rather than creating a new one
- Keep the weekly bullet to one sentence — detail lives in the feature file
