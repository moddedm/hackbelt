# HackBelt 🛠️
A command-line toolbelt for pentesters, CTF players and even normal users that organizes hacking tools, commands, and notes.
## why ?
Have you ever been in a position where you forgot the syntax of a tool so you need to go through man pages
and help commands but they make you more confused or they waste a lot of time and then you proceed to try
countless of times untill you finally find the right command even if you may have used it many times before ?

Well, With hackbelt you can just note everything you need and access them in seconds

## Features ✨
- Instant command reference with `hackbelt <tool>`
- Access CTF-specific tips with `--ctf` flag
- Interactive execution of customizable snippets with `--exec`
- Tag Organization (`#web #crypto #bruteforce`)
- Full search across tools (`--search`)
- Clipboard integration (`--copy`)
- Easy syntax with multiple modes (ex: --list = -l = list) (see Usage for more)
- And many more to come soon

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

# Note : The files created for the tools will be stored per user in ~/.config/hackbelt/files
```
## Usage 🚀
```
Usage:  
  hackbelt <tool> [flag] - Show information about a tool
  hackbelt [--create -c create] <tool> - Create a new tool entry
  hackbelt [--edit -e edit] <tool> - Edit an existing tool entry
  hackbelt [--delete -d delete] <tool> - Delete a tool entry
  hackbelt [--list -l list] [tag] - List all available tools (optionally filtered by tag)
  hackbelt [--search -s search] <term> - Search across all tools
  hackbelt [--tags -t tags] - List all available tags

Flags:
  [--all all]      - Show all information (default)
  [--ctf ctf]     - Show CTF-specific tips
  [--brief brief]   - Show only the brief description
  [--snippets snippets] - Show only the code snippet
  [--flags flags]  - Show only common flags/options
  [--notes notes]   - Show only the notes section
  [--exec exec run]    - Execute the snippet (prompts for placeholders)
  [--copy -cp copy]    - Copy the first snippet to clipboard

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

# This is AI-generated ^^^
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
