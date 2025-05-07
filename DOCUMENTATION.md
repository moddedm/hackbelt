HACKBELT COMPLETE USAGE GUIDE
============================

1. INSTALLATION
---------------
1.1 Basic Install:
    git clone https://github.com/yourusername/hackbelt.git
    cd hackbelt
    chmod +x hackbelt
    sudo cp hackbelt /usr/local/bin/

1.2 Alternative User Install (no sudo):
    mkdir -p ~/.local/bin
    cp hackbelt ~/.local/bin/
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc

2. CORE CONCEPTS
----------------
2.1 Tool Entries:
    - Each tool stores its data in ~/.config/hackbelt/files/
    - Format: Plain text files with sections (see 3.1)

2.2 Key Features:
    - Color-coded output (yellow headers, green snippets)
    - Placeholder replacement (<target>, <port>)
    - Tag-based organization (#web #crypto)

3. TOOL MANAGEMENT
------------------
3.1 File Format:
    # Brief description: [Required]
    Tool description
    
    # Tags: [Optional]
    #category #another_tag
    
    # CTF Tips: [Optional]
    - CTF-specific advice
    
    # Snippet: [Recommended]
    command -flags <placeholder>
    
    # Common Flags: [Optional]
    - -v: Verbose mode
    
    # Notes: [Optional]
    Additional warnings/tips
    
    # Resources: [Optional]
    - [URL] Documentation

3.2 Creating Tools:
    hackbelt --create <toolname>
    hackbelt --edit <toolname>

3.3 Deleting Tools:
    hackbelt --delete <toolname>

4. USAGE EXAMPLES
-----------------
4.1 Basic Viewing:
    hackbelt nmap             # Show all info
    hackbelt hydra --snippet  # Only show commands
    hackbelt ssh --flags      # Only show flags

4.2 Practical Usage:
    # Copy a command to clipboard
    hackbelt sqlmap --snippet --copy
    
    # Execute with placeholders
    hackbelt nc --exec
    [Prompts for <host>, <port>]
    
    # Search all tools
    hackbelt --search "brute force"

5. ADVANCED FEATURES
--------------------
5.1 Tag System:
    # List all tags
    hackbelt --tags
    
    # Filter by tag
    hackbelt --list #web
    
5.2 Placeholder Syntax:
    - Required: <angular_brackets>
    - Convention: <ip>, <port>, <target>
    
5.3 Configuration:
    - Tools stored in: ~/.config/hackbelt/files/
    - Colors customizable in script header
    - The default flag is --all by default but it can also be changed in script header
    - Tool files Directory can be changed in scipt header (TOOL_DIR variable) which is set to linux/MacOS standards by default

5.4 Color Customization
    - All colors are customizable by editing the script it self
    - The color variables are defined at the header so feel free to try different colors

6. TROUBLESHOOTING
------------------
6.1 Common Issues:
    - Missing colors: Ensure terminal supports ANSI colors
    - Command not found: Verify install path
    - Permission denied: Use sudo for system installs

6.2 Debugging:
    # Test color output:
    hackbelt --create test
    hackbelt test --all

6.3 Wrong output of certain flags:
    - Make sure that every section is there even if it is empty
    - hackbelt uses the name of the nest section to detect the end of the current so it needs to be there
    - this is on the list of improvements 

7. BEST PRACTICES
-----------------
7.1 Tool Entries:
    - Keep snippets copy-paste ready
    - Use consistent placeholder names
    - Update when tool versions change

7.2 Organization:
    - Use specific tags (#web-sqli vs #sql-injection)
    - Group related tools with common tags

8. COMMAND REFERENCE
--------------------
8.1 Main Commands:
    --create <tool>    Create new tool entry
    --edit <tool>      Modify existing tool
    --delete <tool>    Remove tool
    --list [#tag]      List available tools
    --search <term>    Search tool contents

8.2 Viewing Flags:
    --all       Show complete info (default)
    --brief     Only description
    --ctf       Only CTF tips
    --snippet   Only command snippets
    --flags     Only common flags
    --notes     Only notes section

8.3 Action Flags:
    --exec      Run command (with prompts)
    --copy      Copy snippet to clipboard

9. EXAMPLE WALKTHROUGH
----------------------
9.1 Creating SSH Tool:
    hackbelt --create ssh
    [Add content in editor]
    
9.2 Using SSH Tool:
    hackbelt ssh --exec
    > Enter <port>:
    2222
    > Enter <target>: 
    10.10.10.1
    > Confirm: ssh -p 2222 10.10.10.1 [Y/n]

10. UNINSTALLATION
------------------
10.1 Full Removal:
    sudo rm /usr/local/bin/hackbelt
    rm -rf ~/.config/hackbelt
