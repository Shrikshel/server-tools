#!/bin/bash

# This script is designed to be run directly on a REMOTE SERVER.
# It will:
# 1. Generate an SSH key pair (ed25519 with 100 KDF rounds) on the remote server,
#    using the server's hostname as part of the key file name.
# 2. Add the newly generated public key to the server's own authorized_keys file,
#    allowing authentication with the corresponding private key.
# 3. Display the path to the private key for manual retrieval (e.g., via scp).
#
# IMPORTANT SECURITY NOTE: Transferring private keys is generally discouraged.
# Ensure you handle the private key with extreme care and delete it from the
# remote server after securely transferring it to your local machine.

# --- Configuration ---
KEY_TYPE="ed25519"
KDF_ROUNDS=100
SERVER_HOSTNAME=$(hostname | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]-.') # Get hostname, convert to lowercase, sanitize
DEFAULT_KEY_FILE="$HOME/.ssh/$SERVER_HOSTNAME-$KEY_TYPE" # Key name now includes hostname
AUTHORIZED_KEYS_FILE="$HOME/.ssh/authorized_keys"

echo "--- SSH Key Generation and Self-Authorization Script (on Remote Server) ---"

# --- Step 1: Generate SSH Key Pair on the Remote Server ---
echo ""
echo "## Step 1: Generating SSH Key Pair on this Remote Server"
echo "A new SSH key pair will be generated using '$KEY_TYPE' algorithm with $KDF_ROUNDS KDF rounds."
echo "The key name will incorporate the server's hostname: $SERVER_HOSTNAME"
echo "You will be prompted to enter a passphrase for your private key. It's highly recommended"
echo "to use a strong passphrase for enhanced security."

# Ensure .ssh directory exists and has correct permissions
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Check if keys already exist
if [ -f "$DEFAULT_KEY_FILE" ] || [ -f "$DEFAULT_KEY_FILE.pub" ]; then
    read -p "Key files ($DEFAULT_KEY_FILE and $DEFAULT_KEY_FILE.pub) already exist. Overwrite? (y/N): " overwrite_choice
    if [[ ! "$overwrite_choice" =~ ^[Yy]$ ]]; then
        echo "Aborting key generation. Using existing keys."
        GENERATED_KEY=false
    else
        echo "Overwriting existing keys..."
        # Remove existing keys to avoid conflicts during generation
        rm -f "$DEFAULT_KEY_FILE" "$DEFAULT_KEY_FILE.pub"
        # Generate new keys
        ssh-keygen -t "$KEY_TYPE" -a "$KDF_ROUNDS" -f "$DEFAULT_KEY_FILE"
        GENERATED_KEY=true
    fi
else
    # Generate new keys if they don't exist
    ssh-keygen -t "$KEY_TYPE" -a "$KDF_ROUNDS" -f "$DEFAULT_KEY_FILE"
    GENERATED_KEY=true
fi

# Exit if key generation failed or was aborted
if [ ! -f "$DEFAULT_KEY_FILE" ] || [ ! -f "$DEFAULT_KEY_FILE.pub" ]; then
    echo "Error: SSH key generation failed or was aborted. Exiting."
    exit 1
fi

if [ "$GENERATED_KEY" = true ]; then
    echo "SSH key pair generated successfully:"
    echo "  Private Key: $DEFAULT_KEY_FILE"
    echo "  Public Key:  $DEFAULT_KEY_FILE.pub"
    echo "REMEMBER: This private key ($DEFAULT_KEY_FILE) is what you need to download securely."
fi

# --- Step 2: Add Public Key to this Server's Authorized Hosts ---
echo ""
echo "## Step 2: Adding Public Key to this Server's Authorized Keys"
echo "The public key ($DEFAULT_KEY_FILE.pub) will be added to $AUTHORIZED_KEYS_FILE"
echo "This will allow you to authenticate with the corresponding private key."

PUBLIC_KEY_CONTENT=$(cat "$DEFAULT_KEY_FILE.pub")
if [ -z "$PUBLIC_KEY_CONTENT" ]; then
    echo "Error: Could not read public key content from $DEFAULT_KEY_FILE.pub. Aborting."
    exit 1
fi

# Append the public key to authorized_keys and set correct permissions
echo "$PUBLIC_KEY_CONTENT" >> "$AUTHORIZED_KEYS_FILE"
chmod 600 "$AUTHORIZED_KEYS_FILE"

echo "Public key successfully added to $AUTHORIZED_KEYS_FILE."
echo "You can now use the private key from this server to log in from another machine."

# --- Step 3: Important Next Steps ---
echo ""
echo "## Step 3: Retrieve Your Private Key (IMPORTANT)"
echo "Your private key is located at: $DEFAULT_KEY_FILE"
echo "You need to securely download this file to your local machine."
echo "From your LOCAL machine, use 'scp' to download it. For example:"
echo ""
echo "  scp ${USER}@$(hostname):$DEFAULT_KEY_FILE ~/Downloads/"
echo ""
echo "Replace '~/Downloads/' with your desired local path."
echo ""
echo "!!! SECURITY WARNING !!!"
echo "After securely downloading the private key to your local machine, it is"
echo "STRONGLY RECOMMENDED to delete the private key from this remote server."
echo "You can do this using: rm $DEFAULT_KEY_FILE"
echo "This minimizes the risk of the private key being compromised on the server."
echo ""
echo "Once the private key is on your local machine, ensure its permissions are set correctly:"
echo "  chmod 600 ~/Downloads/$SERVER_HOSTNAME-$KEY_TYPE" # Updated example chmod
echo ""
echo "Then, you can use it to log in from your local machine:"
echo "  ssh -i ~/Downloads/$SERVER_HOSTNAME-$KEY_TYPE ${USER}@$(hostname)" # Updated example ssh command
echo ""
echo "--- Script Finished ---"
