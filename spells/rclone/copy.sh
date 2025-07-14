#!/bin/bash

SRC="${args[source]}"
DST="${args[destination]}"

# Check arguments
if [[ -z "$SRC" || -z "$DST" ]]; then
    log_error "Usage: rclone copy <source> <destination>"
    log_info "Example: rclone copy local/path remote:bucket/path"
    exit 1
fi

# Check if rclone is installed
if ! command -v rclone &> /dev/null; then
    log_error "rclone is not installed."
    log_info "Please install rclone: https://rclone.org/install/"
    exit 1
fi

# Check if source exists (local or remote)
if [[ "$SRC" == *:* ]]; then
    log_info "Assuming '$SRC' is a remote. Skipping local existence check."
else
    if [ ! -e "$SRC" ]; then
        log_error "Source path '$SRC' does not exist."
        exit 1
    fi
fi

# Check if destination exists (local or remote)
if [[ "$DST" == *:* ]]; then
    log_info "Assuming '$DST' is a remote. Skipping local existence check."
else
    if [ ! -e "$DST" ]; then
        log_error "Destination path '$DST' does not exist."
        exit 1
    fi
fi

# Confirm before starting copy
echo
log_info "Ready to perform copy from:"
echo "  Source:      $SRC"
echo "  Destination: $DST"
read -rp "Proceed with copy? (y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    log_info "Aborted by user."
    exit 0
fi

# Run rclone copy
log_info "Starting rclone copy..."
rclone copy "$SRC" "$DST" \
    --progress \
    --stats=10s \
    --transfers=8 \
    --checkers=16 \
    --verbose

log_info "Copy completed."
