# Ensure YAML file exists
if [[ ! -f "$ST_RESTIC_PROFILE_FILE" ]]; then
    log_error "Profile file not found: $ST_RESTIC_PROFILE_FILE"
    exit 1
fi

# Ensure profiles list is available
if [[ -z "$ST_RESTIC_PROFILES" ]]; then
    log_error "No profiles defined in ST_RESTIC_PROFILES"
    exit 1
fi

# Convert profile list to array
IFS=' ' read -r -a profiles <<<"$ST_RESTIC_PROFILES"

# Determine profile
if [[ -n "${args[profile]}" ]]; then
    profile="${args[profile]}"
    found=0
    for p in "${profiles[@]}"; do
        if [[ "$p" == "$profile" ]]; then
            found=1
            break
        fi
    done
    if [[ $found -eq 0 ]]; then
        log_error "Provided profile '${args[profile]}' is not in ST_RESTIC_PROFILES"
        exit 1
    fi
elif [[ ${#profiles[@]} -eq 1 ]]; then
    profile="${profiles[0]}"
    log_info "Only one profile found. Auto-selecting: $profile"
else
    log_info "Available Restic Profiles:"
    echo
    for i in "${!profiles[@]}"; do
        printf "\033[1;36m%10s\033[0m  %s\n" "[$((i + 1))]" "${profiles[$i]}"
    done

    echo
    printf "\033[1;38;5;208m%10s  %s\033[0m " "INPUT" "Select a profile number or name: "
    read -r selection

    if [[ "$selection" =~ ^[0-9]+$ ]] && ((selection >= 1 && selection <= ${#profiles[@]})); then
        profile="${profiles[$((selection - 1))]}"
    else
        found=0
        for p in "${profiles[@]}"; do
            if [[ "$p" == "$selection" ]]; then
                profile="$p"
                found=1
                break
            fi
        done
        if [[ $found -eq 0 ]]; then
            log_error "Invalid selection: $selection"
            exit 1
        fi
    fi
fi

log_info "Selected profile: $profile"
echo

# Handle extra flags (e.g. --mode for stats)
extra_args=()

log_info "Available stats modes:"
log "38;5;208" "CHOICE" "1) restore-size"
log "38;5;208" "CHOICE" "2) files-by-contents"
log "38;5;208" "CHOICE" "3) raw-data"
log_inline 32 "INPUT" "Select a mode number or name [raw-data]: "
read -r mode_selection

case "$mode_selection" in
1 | "restore-size")
    mode="restore-size"
    ;;
2 | "files-by-contents")
    mode="files-by-contents"
    ;;
3 | "raw-data")
    mode="raw-data"
    ;;
*)
    log_error "Invalid mode selection: $mode_selection"
    exit 1
    ;;
esac
extra_args+=("--mode" "$mode")

# Run resticprofile stats
log_info "Running: resticprofile -c $ST_RESTIC_PROFILE_FILE -n $profile stats ${extra_args[@]}"
echo
resticprofile -c "$ST_RESTIC_PROFILE_FILE" -n "$profile" stats "${extra_args[@]}" || log_error "Failed to run resticprofile stats"
echo
