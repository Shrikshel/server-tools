log_info_box "Uninstalling all system utilities..."

st uninstall vnstat
st uninstall docker
st uninstall btop
st uninstall eza
st uninstall ncdu
st uninstall duf
st uninstall ufw
st uninstall bat
st uninstall resticprofile
st uninstall rclone
st uninstall restic

log_info_box "All system utilities have been uninstalled successfully. You can now reinstall them as needed."
log_info "Below is the list of uninstalled utilities:"
log_info "vnstat, docker, btop, eza, ncdu, duf, ufw, bat, resticprofile, rclone, restic"