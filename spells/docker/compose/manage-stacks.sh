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

# Get all subdirectories in the parent directory
mapfile -t dirs < <(find "$PARENT_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

# Exit if no directories found
if [[ ${#dirs[@]} -eq 0 ]]; then
  echo "No application directories found in $PARENT_DIR"
  exit 1
fi

while true; do
  echo
  echo "--------------------------"
  echo "Docker App Stack Manager"
  echo "--------------------------"
  echo "0) Exit"

  for i in "${!dirs[@]}"; do
    dir_name=$(basename "${dirs[$i]}")
    echo "$((i + 1))) $dir_name"
  done

  start_all_option=$(( ${#dirs[@]} + 1 ))
  stop_all_option=$(( ${#dirs[@]} + 2 ))

  echo "$start_all_option) Start All"
  echo "$stop_all_option) Stop All"

  read -p "Enter a number: " user_input

  if ! [[ "$user_input" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a number."
    continue
  fi

  case "$user_input" in
    0)
      echo "Exiting..."
      break
      ;;
    $start_all_option)
      echo "Starting all Docker stacks..."
      for dir in "${dirs[@]}"; do
        app_name=$(basename "$dir")
        echo "Starting $app_name..."
        cd "$dir" && docker compose up -d --build || echo "Failed to start $app_name"
      done
      ;;
    $stop_all_option)
      echo "Stopping all Docker stacks..."
      for dir in "${dirs[@]}"; do
        app_name=$(basename "$dir")
        echo "Stopping $app_name..."
        cd "$dir" && docker compose down || echo "Failed to stop $app_name"
      done
      ;;
    *)
      index=$((user_input - 1))
      if [[ "$index" -lt 0 || "$index" -ge "${#dirs[@]}" ]]; then
        echo "Invalid selection! Please try again."
        continue
      fi

      selected_path="${dirs[$index]}"
      selected_app=$(basename "$selected_path")

      echo
      echo "Selected: $selected_app"
      echo "1) Start"
      echo "2) Stop"
      echo "3) Logs"
      echo "4) Restart"
      echo "5) Status"
      echo "6) Show .env"
      echo "7) Shell into container"
      read -p "Enter action number: " action_input

      case "$action_input" in
        1)
          echo "Starting $selected_app..."
          cd "$selected_path" && docker compose up -d --build
          ;;
        2)
          echo "Stopping $selected_app..."
          cd "$selected_path" && docker compose down
          ;;
        3)
          echo "Showing logs for $selected_app..."
          cd "$selected_path" && docker compose logs -f
          ;;
        4)
          echo "Restarting $selected_app..."
          cd "$selected_path" && docker compose restart
          ;;
        5)
          echo "Status for $selected_app:"
          cd "$selected_path" && docker compose ps
          ;;
        6)
          if [[ -f "$selected_path/.env" ]]; then
            echo ".env file for $selected_app:"
            echo "-------------------------------"
            cat "$selected_path/.env"
            echo "-------------------------------"
          else
            echo "No .env file found for $selected_app"
          fi
          ;;
        7)
          cd "$selected_path"
          echo "Available services:"
          docker compose config --services
          read -p "Enter service name to shell into: " service
          echo "Opening bash shell in $service..."
          docker compose exec "$service" bash || echo "Failed to shell into $service"
          ;;
        *)
          echo "Invalid action selected."
          ;;
      esac
      ;;
  esac
done
