log_info "Checking if Docker is installed..."
if ! command -v docker &>/dev/null; then
    log_error "Docker is not installed. Please install it before running this script."
    exit 1
fi
log_success "Docker is installed."

echo

log_info "Checking if all required environment variables are set..."
check_required_env_vars ST_DOCKER_STACKS_PROD_PATH
log_success "All required environment variables are set."

echo

PARENT_DIR="$ST_DOCKER_STACKS_PROD_PATH"

echo "🔍 Searching for Docker stacks in: $PARENT_DIR"
errors=0
for DIR in "$PARENT_DIR"/*/; do
  if [[ -f "$DIR/docker-compose.yml" || -f "$DIR/docker-compose.yaml" ]]; then
    echo "🛑 Stopping stack in: $DIR"
    if cd "$DIR"; then
      docker compose down || {
        echo "❌ Failed to stop stack in $DIR"
        ((errors++))
      }
    else
      echo "❌ Cannot access directory: $DIR"
      ((errors++))
    fi
  else
    echo "⚠️ No docker-compose file in $DIR — skipping"
  fi
done
if [[ $errors -eq 0 ]]; then
  echo "✅ All stacks stopped successfully."
else
  echo "⚠️ $errors stack(s) failed to stop."
fi
