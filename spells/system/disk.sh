#!/usr/bin/env bash

if ! command -v duf &>/dev/null; then
    log_info_box "Please install duf with command 'st system install duf'."
else
    duf 
fi
