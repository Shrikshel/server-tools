# lib/your_script_name_helper.sh (Add this to your helper file)

# Function to print a line segment with specified character, length, alignment, and color.
# Usage: print_segment [CHARACTER] [PERCENTAGE_WIDTH] [ALIGNMENT] [COLOR_CODE]
# CHARACTER: The character to use for the segment (defaults to '#').
# PERCENTAGE_WIDTH: The length of the segment as a percentage of terminal width (e.g., 50 for half).
#                   Defaults to 50 if not provided. Max 100.
# ALIGNMENT: 'left', 'right', or 'center'. Defaults to 'center' if not provided or invalid.
# COLOR_CODE: A numeric ANSI color code (e.g., 1 for red, 2 for green) or a tput color name.
#             If not provided, no color will be applied.
#
# Examples:
# print_segment "=" 50 "center" "green" # Green half line, centered
# print_segment "*" 30 "left" "yellow"   # Yellow 30% line, left-aligned
# print_segment "-" 75 "right" "blue"    # Blue 75% line, right-aligned
add_separator() {
    local segment_char="${1:-#}"           # Default to '#'
    local percentage="${2:-50}"            # Default to 50%
    local alignment="${3:-center}"         # Default to 'center'
    local color_arg="${4}"                 # Optional color argument

    local terminal_width=$(tput cols)
    local color_start=""
    local color_reset="$(tput sgr0)"

    # Fallback for when terminal width cannot be determined
    if [[ -z "$terminal_width" || "$terminal_width" -eq 0 ]]; then
        terminal_width=80
    fi

    # Ensure percentage is within reasonable bounds (1 to 100)
    if (( percentage < 1 )); then percentage=1; fi
    if (( percentage > 100 )); then percentage=100; fi

    # Calculate the width of the segment
    local segment_width=$(( (terminal_width * percentage) / 100 ))

    # Ensure segment_width is at least 1 if percentage > 0
    if (( segment_width == 0 && percentage > 0 )); then segment_width=1; fi

    # Calculate padding based on alignment
    local padding_left=0
    local padding_right=0
    local total_remaining_space=$(( terminal_width - segment_width ))

    case "${alignment}" in
        left)
            padding_right="$total_remaining_space"
            ;;
        right)
            padding_left="$total_remaining_space"
            ;;
        center)
            padding_left=$(( total_remaining_space / 2 ))
            padding_right=$(( total_remaining_space - padding_left ))
            ;;
        *)
            # Default to center for invalid alignment values
            padding_left=$(( total_remaining_space / 2 ))
            padding_right=$(( total_remaining_space - padding_left ))
            ;;
    esac

    # Determine color escape sequence
    if [[ -n "$color_arg" ]]; then
        if [[ "$color_arg" =~ ^[0-9]+$ ]]; then
            color_start="$(tput setaf "$color_arg")"
        else
            case "$color_arg" in
                black) color_start="$(tput setaf 0)";;
                red) color_start="$(tput setaf 1)";;
                green) color_start="$(tput setaf 2)";;
                yellow) color_start="$(tput setaf 3)";;
                blue) color_start="$(tput setaf 4)";;
                magenta) color_start="$(tput setaf 5)";;
                cyan) color_start="$(tput setaf 6)";;
                white) color_start="$(tput setaf 7)";;
                *) color_start=""
            esac
        fi
    fi

    # Print the left padding spaces
    printf "%${padding_left}s" ""

    # Print the colored segment characters
    printf "${color_start}"
    head -c "$segment_width" < /dev/zero | tr '\0' "$segment_char"
    printf "${color_reset}"

    # Print the right padding spaces and a newline
    printf "%${padding_right}s\n" ""
}