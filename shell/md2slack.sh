# md2slack — pipe a Markdown file to the clipboard in Slack-friendly plain text
#
# Usage:
#   cat file.md | md2slack | pbcopy
#
# Strips bold (**), italic (*), headers (#), inline code (`), and empty lines.
md2slack() {
  sed -E 's/\*\*//g; s/__//g; s/\*//g; s/`//g; s/^#+[[:space:]]*//' | grep -v '^[[:space:]]*$'
}
