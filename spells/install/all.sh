log_info_box "Installing all system utilities..."

st install vnstat
st install docker
st install btop
st install eza
st install ncdu
st install duf
st install ufw
st install bat
st install resticprofile
st install rclone
st install restic

log_info_box "All system utilities have been installed successfully. You can now use them as needed."

log_info "Below is the list of installed utilities:"
log_info "vnstat, docker, btop, eza, ncdu, duf, ufw, bat, resticprofile, rclone, restic"