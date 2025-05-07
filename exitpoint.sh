#!/bin/bash

# Set working directory to script location
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"

# Log file
LOG_FILE="shutdown_log.txt"
LOG_DIR="logs"

# Create logs directory if not exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Creating logs directory: $LOG_DIR"
    mkdir -p "$LOG_DIR"
fi

echo "[$(date)] Starting shutdown process" >> "$LOG_FILE"
echo "======================================"
echo "       XXXBot Linux Shutdown Script   "
echo "======================================"
echo "Stopping services...Please wait..."

# Activate Conda environment
if ! command -v conda &> /dev/null; then
    echo "Error: Conda is not installed. Please install Conda first."
    echo "[$(date)] Error: Conda is not installed" >> "$LOG_FILE"
    exit 1
fi

# Activate the xxxbot Conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate xxxbot
if [ $? -ne 0 ]; then
    echo "Error: Failed to activate Conda environment 'xxxbot'."
    echo "[$(date)] Error: Failed to activate Conda environment 'xxxbot'" >> "$LOG_FILE"
    exit 1
fi

echo "[$(date)] Conda environment 'xxxbot' activated" >> "$LOG_FILE"

# Function to check and stop screen session
check_and_stop_session() {
    local session_name="$1"
    if screen -list | grep -q "$session_name"; then
        echo "Stopping $session_name session..."
        screen -S "$session_name" -X quit
        if [ $? -eq 0 ]; then
            echo "Successfully stopped $session_name session"
            echo "[$(date)] Successfully stopped $session_name session" >> "$LOG_FILE"
        else
            echo "Failed to stop $session_name session"
            echo "[$(date)] Failed to stop $session_name session" >> "$LOG_FILE"
        fi
    else
        echo "$session_name session not found, skipping..."
        echo "[$(date)] $session_name session not found, skipping..." >> "$LOG_FILE"
    fi
}

# Stop services in reverse order
echo "Stopping main application..."
check_and_stop_session "wxbot_main"

echo "Stopping PAD service..."
check_and_stop_session "pad_service"

echo "Stopping Redis server..."
check_and_stop_session "redis_service"

# Check if any XXXBot related screen sessions still exist
REMAINING=$(screen -list | grep -E 'redis_service|pad_service|wxbot_main' | wc -l)

if [ "$REMAINING" -gt 0 ]; then
    echo "Warning: Some sessions may still be running. Check with 'screen -ls'"
    echo "[$(date)] Warning: Some sessions may still be running" >> "$LOG_FILE"
else
    echo "All XXXBot services have been stopped successfully."
    echo "[$(date)] All XXXBot services have been stopped successfully" >> "$LOG_FILE"
fi

echo "[$(date)] Shutdown process completed" >> "$LOG_FILE"
echo ""
echo "To check any remaining sessions use: screen -ls"