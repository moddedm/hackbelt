# HackBelt 🛠️

**Your Cybersecurity Swiss Army Knife** - A command-line toolbelt for pentesters and CTF players that organizes hacking tools, commands, and notes.

## Features ✨
- Instant command reference with `hackbelt <tool>`
- CTF-specific tips with `--ctf` flag
- Interactive execution with `--exec` (replaces `<placeholders>`)
- Tag organization (`#web #crypto #bruteforce`)
- Clipboard integration (`--copy`)
- Full search across tools (`--search`)

## Recommended Installation

```bash
git clone https://github.com/moddedm/hackbelt.git
cd hackbelt
chmod +x hackbelt

# Preferred: User-local install (no sudo)
mkdir -p ~/.local/bin
cp hackbelt ~/.local/bin/
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.bashrc
source ~/.bashrc

# Alternative: System-wide install (requires sudo)
sudo cp hackbelt /usr/local/bin/

# Note : The files created for the tools will be stored per user in ~/.config/files
```
## Usage 🚀
```
Usage:
  hackbelt <tool> [flag] - Show information about a tool
  hackbelt --create <tool> - Create a new tool entry
  hackbelt --edit <tool> - Edit an existing tool entry
  hackbelt --delete <tool> - Delete a tool entry
  hackbelt --list [tag] - List all available tools (optionally filtered by tag)
  hackbelt --search <term> - Search across all tools
  hackbelt --tags - List all available tags
Flags:
  --all      - Show all information (default)
  --brief    - Show only the brief description
  --ctf      - Show CTF-specific tips
  --snippet  - Show only the code snippet
  --flags    - Show only common flags/options
  --notes    - Show only the notes section
  --exec     - Execute the snippet (prompts for placeholders)
  --copy     - Copy the first snippet to clipboard
Examples:
  hackbelt hydra
  hackbelt nmap --snippet --copy
  hackbelt --create sqlmap
  hackbelt --search 'brute force'
  hackbelt --list #web
```
## Example Tool Entry (nmap)📝
```
# Brief description:
Port scanning and network discovery

# Tags: 
#scanning #enumeration #network

# CTF Tips:
- Always scan all ports (-p-)
- Check service versions (-sV)

# Snippet:
# Basic scan
nmap -sC -sV <target>

# Common Flags:
- -sC: Default scripts
- -sV: Service detection

# Notes:
- Can be noisy on monitored networks
- Use -Pn for ping-blocked hosts
```
## What can you do?
1. Suggest Improvements
2. I am planning on making some predefined entries for popular tools , so feel free to help me make them :)

## How to Suggest Improvements
1. For tool/command ideas:
   - Open a [Discussion](https://github.com/moddedm/hackbelt/discussions/new/choose) under "Ideas"
   - OR reply to the [Imporvement requests](https://github.com/moddedm/hackbelt/discussions/1) discussion

2. For documentation fixes:
   - Click "Edit this page" on any doc
   - Submit via Pull Request

3. Best practices:
   - Search existing suggestions first
   - Include use cases ("For CTFs when...")
   - Reference similar tools if applicable
