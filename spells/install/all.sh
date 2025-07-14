log_info_box "Installing all system utilities..."

st system install vnstat
st system install docker
st system install btop
st system install eza
st system install ncdu
st system install duf
st system install ufw
st system install bat
st system install resticprofile
st system install rclone
st system install restic

log_info_box "All system utilities have been installed successfully. You can now use them as needed."

log_info "Below is the list of installed utilities:"
log_info "vnstat, docker, btop, eza, ncdu, duf, ufw, bat, resticprofile, rclone, restic"