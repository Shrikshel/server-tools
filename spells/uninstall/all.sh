log_info_box "Uninstalling all system utilities..."

st system uninstall vnstat
st system uninstall docker
st system uninstall btop
st system uninstall eza
st system uninstall ncdu
st system uninstall duf
st system uninstall ufw
st system uninstall bat
st system uninstall resticprofile
st system uninstall rclone
st system uninstall restic

log_info_box "All system utilities have been uninstalled successfully. You can now reinstall them as needed."
log_info "Below is the list of uninstalled utilities:"
log_info "vnstat, docker, btop, eza, ncdu, duf, ufw, bat, resticprofile, rclone, restic"