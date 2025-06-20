#!/bin/bash

if ! command -v neofetch &>/dev/null; then
    pretty_info "Please install neofetch with command 'st system install neofetch'."
else
    # Print system info
    neofetch 
fi