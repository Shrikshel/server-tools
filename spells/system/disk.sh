#!/usr/bin/env bash

if ! command -v duf &>/dev/null; then
    pretty_info "Please install duf with command 'st system install duf'."
else
    duf 
fi
