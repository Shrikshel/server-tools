#!/bin/bash

if ! command -v neofetch &>/dev/null; then
    log_info_box "Please install neofetch with command 'st system install neofetch'."
else
    # Print system info
    neofetch 
fi