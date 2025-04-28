#!/usr/bin/env bash

# HackBelt - Cybersecurity CTF Helper Tool
# Author: moddedm
# Version: 2.0

# Configuration
TOOL_DIR="$(dirname "$0")/files"
DEFAULT_FLAG="--all"
EDITOR="${EDITOR:-nano}"  # Default to nano if EDITOR not set
COLOR_HEADER="\033[1;36m"  # Cyan
COLOR_SECTION="\033[1;33m" # Yellow
COLOR_SNIPPET="\033[1;32m" # Green
COLOR_RESET="\033[0m"      # Reset

# Create files directory if it doesn't exist
mkdir -p "$TOOL_DIR"

# Help function
show_help() {
    echo -e "${COLOR_HEADER}HackBelt - Cybersecurity CTF Helper Tool${COLOR_RESET}"
    echo "Usage:"
    echo "  hackbelt <tool> [flag] - Show information about a tool"
    echo "  hackbelt --create <tool> - Create a new tool entry"
    echo "  hackbelt --edit <tool> - Edit an existing tool entry"
    echo "  hackbelt --delete <tool> - Delete a tool entry"
    echo "  hackbelt --list - List all available tools"
    echo "  hackbelt --search <term> - Search across all tools"
    echo ""
    echo "Flags:"
    echo "  --all      - Show all information (default)"
    echo "  --brief    - Show only the brief description"
    echo "  --ctf      - Show CTF-specific tips"
    echo "  --snippet  - Show only the code snippet"
    echo "  --flags    - Show only common flags/options"
    echo "  --notes    - Show only the notes section"
    echo ""
    echo "Examples:"
    echo "  hackbelt hydra"
    echo "  hackbelt nmap --snippet"
    echo "  hackbelt --create sqlmap"
    echo "  hackbelt --search 'brute force'"
}

# Print section with color
print_section() {
    echo -e "\n${COLOR_SECTION}=== $1 ===${COLOR_RESET}"
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
        {
            echo "# Brief description:" 
            echo "Brief description of $2 goes here." 
            echo ""
            echo "# CTF Tips:" 
            echo "CTF-specific tips for $2 go here." 
            echo ""
            echo "# Snippet:" 
            echo "# Copy-paste ready examples (use ${COLOR_SNIPPET}${COLOR_SECTION} for colored output):"
            echo "Common usage snippet for $2 goes here." 
            echo ""
            echo "# Common Flags:" 
            echo "Common flags/options for $2 go here."
            echo ""
            echo "# Notes:" 
            echo "Additional notes, caveats, or advanced usage for $2 go here."
            echo ""
            echo "# Resources:" 
            echo "Helpful links, man pages, or cheatsheets for $2"
        } > "$tool_file"
        
        echo "Tool entry created. You can now edit it with: hackbelt --edit $2"
        $EDITOR "$tool_file"
        exit 0
        ;;
    --edit)
        if [ -z "$2" ]; then
            echo "Error: No tool name specified for editing."
            exit 1
        fi
        tool_file="$TOOL_DIR/$2"
        if [ ! -f "$tool_file" ]; then
            read -p "Tool '$2' doesn't exist. Create it? (y/n) " confirm
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                hackbelt --create "$2"
                exit 0
            else
                exit 1
            fi
        fi
        
        $EDITOR "$tool_file"
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
        echo -e "${COLOR_HEADER}Available tools:${COLOR_RESET}"
        ls -1 "$TOOL_DIR" | sed 's/^/  /'
        echo -e "\nUse 'hackbelt <tool> --brief' for quick descriptions"
        exit 0
        ;;
    --search)
        if [ -z "$2" ]; then
            echo "Error: No search term specified."
            exit 1
        fi
        echo -e "${COLOR_HEADER}Search results for '$2':${COLOR_RESET}"
        grep -ril "$2" "$TOOL_DIR" | while read -r file; do
            tool_name=$(basename "$file")
            echo -e "\n${COLOR_SECTION}${tool_name}${COLOR_RESET}"
            grep -i "$2" "$file" | head -n 3 | sed 's/^/  /'
        done
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
    echo "Or create it with: hackbelt --create $tool"
    exit 1
fi

# Display the appropriate section based on the flag
case "$flag" in
    --all)
        echo -e "${COLOR_HEADER}=== $tool ===${COLOR_RESET}"
        # Process the file to add colors to snippets
        awk -v color_snippet="$COLOR_SNIPPET" -v color_reset="$COLOR_RESET" '
            /^# Snippet:/ { 
                print "\033[1;33m" $0 "\033[0m"; 
                in_snippet=1; 
                next 
            }
            /^# [A-Za-z]+:/ { 
                in_snippet=0 
            }
            in_snippet && /^[^#]/ { 
                print color_snippet $0 color_reset; 
                next 
            }
            /^# [A-Za-z]+:/ { 
                print "\033[1;33m" $0 "\033[0m" 
            }
            { print }
        ' "$tool_file"
        ;;
    --brief)
        print_section "Brief Description"
        awk '/^# Brief description:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    --ctf)
        print_section "CTF Tips"
        awk '/^# CTF Tips:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    --snippet)
        print_section "Snippets (Copy-paste ready)"
        awk -v color_snippet="$COLOR_SNIPPET" -v color_reset="$COLOR_RESET" '
            /^# Snippet:/ {flag=1; next} 
            /^# [A-Za-z]+:/ {flag=0} 
            flag {print color_snippet $0 color_reset}
        ' "$tool_file"
        ;;
    --flags)
        print_section "Common Flags/Options"
        awk '/^# Common Flags:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    --notes)
        print_section "Notes"
        awk '/^# Notes:/ {flag=1; next} /^# [A-Za-z]+:/ {flag=0} flag' "$tool_file"
        ;;
    *)
        echo "Error: Unknown flag '$flag'"
        show_help
        exit 1
        ;;
esac