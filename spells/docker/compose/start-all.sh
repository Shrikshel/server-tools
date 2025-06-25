log_info "Checking if Docker is installed..."
if ! command -v docker &>/dev/null; then
    log_error "Docker is not installed. Please install it before running this script."
    exit 1
fi
log_success "Docker is installed."

echo

log_info "Checking if all required environment variables are set..."
check_required_env_vars ST_PROD_STACKS_PATH
log_success "All required environment variables are set."

echo

PARENT_DIR="$ST_PROD_STACKS_PATH"

echo "🔍 Searching for Docker stacks in: $PARENT_DIR"
errors=0

for DIR in "$PARENT_DIR"/*/; do
  # Check for docker-compose.yml or .yaml
  if [[ -f "$DIR/docker-compose.yml" || -f "$DIR/docker-compose.yaml" ]]; then
    echo "🚀 Starting stack in: $DIR"
    if cd "$DIR"; then
      docker compose up -d --build || {
        echo "❌ Failed to start stack in $DIR"
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
  echo "✅ All stacks started successfully."
else
  echo "⚠️ $errors stack(s) failed to start."
fi
