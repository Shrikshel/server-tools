log_info "Running Network Speed Test..."
curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
log_success "Network Speed Test completed successfully."