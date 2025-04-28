#!/usr/bin/env bash

# HackBelt - Cybersecurity CTF Helper Tool
# Author: moddedm
# Version: 1.0

# Configuration
TOOL_DIR="$(dirname "$0")/files"
DEFAULT_FLAG="--all"

# Create files directory if it doesn't exist
mkdir -p "$TOOL_DIR"

# Help function
show_help() {
    echo "HackBelt - Cybersecurity CTF Helper Tool"
    echo "Usage:"
    echo "  hackbelt <tool> [flag] - Show information about a tool"
    echo "  hackbelt --create <tool> - Create a new tool entry"
    echo "  hackbelt --edit <tool> - Edit an existing tool entry"
    echo "  hackbelt --delete <tool> - Delete a tool entry"
    echo "  hackbelt --list - List all available tools"
    echo ""
    echo "Flags:"
    echo "  --all      - Show all information (default)"
    echo "  --brief    - Show only the brief description"
    echo "  --ctf      - Show CTF-specific tips"
    echo "  --snippet  - Show only the code snippet"
    echo "  --flags    - Show only common flags/options"
    echo ""
    echo "Examples:"
    echo "  hackbelt hydra"
    echo "  hackbelt nmap --snippet"
    echo "  hackbelt --create sqlmap"
}

# Check if no arguments provided
if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

# Handle special commands
case "$1" in
    --help|-h)
        show_help
        exit 0
        ;;
    --create)
        if [ -z "$2" ]; then
            echo "Error: No tool name specified for creation."
            exit 1
        fi
        tool_file="$TOOL_DIR/$2"
        if [ -f "$tool_file" ]; then
            echo "Error: Tool '$2' already exists."
            exit 1
        fi
        
        echo "Creating new tool entry: $2"
        echo "# Brief description:" > "$tool_file"
        echo "Brief description of $2 goes here." >> "$tool_file"
        echo "" >> "$tool_file"
        echo "# CTF Tips:" >> "$tool_file"
        echo "CTF-specific tips for $2 go here." >> "$tool_file"
        echo "" >> "$tool_file"
        echo "# Snippet:" >> "$tool_file"
        echo "Common usage snippet for $2 goes here." >> "$tool_file"
        echo "" >> "$tool_file"
        echo "# Common Flags:" >> "$tool_file"
        echo "Common flags/options for $2 go here." >> "$tool_file"
        
        echo "Tool entry created. You can now edit it with: hackbelt --edit $2"
        exit 0
        ;;
    --edit)
        if [ -z "$2" ]; then
            echo "Error: No tool name specified for editing."
            exit 1
        fi
        tool_file="$TOOL_DIR/$2"
        if [ ! -f "$tool_file" ]; then
            echo "Error: Tool '$2' does not exist. Create it first with --create."
            exit 1
        fi
        
        # Use the default editor, fallback to nano
        "${EDITOR:-nano}" "$tool_file"
        exit 0
        ;;
    --delete)
        if [ -z "$2" ]; then
            echo "Error: No tool name specified for deletion."
            exit 1
        fi
        tool_file="$TOOL_DIR/$2"
        if [ ! -f "$tool_file" ]; then
            echo "Error: Tool '$2' does not exist."
            exit 1
        fi
        
        read -p "Are you sure you want to delete the tool entry '$2'? (y/n) " confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            rm "$tool_file"
            echo "Tool entry '$2' deleted."
        else
            echo "Deletion cancelled."
        fi
        exit 0
        ;;
    --list)
        echo "Available tools:"
        ls -1 "$TOOL_DIR" | sed 's/^/  /'
        exit 0
        ;;
esac

# Normal tool lookup
tool="$1"
flag="${2:-$DEFAULT_FLAG}"
tool_file="$TOOL_DIR/$tool"

if [ ! -f "$tool_file" ]; then
    echo "Error: Tool '$tool' not found."
    echo "List available tools with: hackbelt --list"
    exit 1
fi

# Display the appropriate section based on the flag
case "$flag" in
    --all)
        echo "=== $tool ==="
        cat "$tool_file"
        ;;
    --brief)
        awk '/^# Brief description:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    --ctf)
        awk '/^# CTF Tips:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    --snippet)
        awk '/^# Snippet:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    --flags)
        awk '/^# Common Flags:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    *)
        echo "Error: Unknown flag '$flag'"
        show_help
        exit 1
        ;;
esac