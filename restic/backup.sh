#/bin/zsh

PATH=/usr/bin:/bin:/opt/homebrew/bin
source $HOME/dotfiles/env
last_snapshot_file="$HOME/.restic/last_snapshot"

# Only run backup if last backup is from 2+ days ago
check_two_days_apart() {
  local timestamp_file="$1"
  
  if [ -f "$timestamp_file" ]; then
    # Read the timestamp from the file
    local timestamp=$(cat "$timestamp_file")

    # Extract the date component (day)
    local date_part=$(echo "$timestamp" | cut -d 'T' -f 1)

    # Convert the date component to an epoch timestamp
    local timestamp_epoch=$(date -j -f "%Y-%m-%d" "$date_part" +%s)

    # Calculate the current date in epoch seconds
    local current_date=$(date -u +%Y-%m-%d)

    # Convert the current date to an epoch timestamp
    local current_date_epoch=$(date -j -f "%Y-%m-%d" "$current_date" +%s)

    # Calculate the time difference in seconds
    local time_difference=$((current_date_epoch - timestamp_epoch))

    # Define the threshold for 2 days (2 days * 24 hours * 60 minutes * 60 seconds)
    local threshold=$((2 * 24 * 60 * 60))

    # Check if the time difference is greater than or equal to the threshold
    if [ "$time_difference" -ge "$threshold" ]; then
      echo "The current date is at least two days apart from the timestamp date."
      return 0
    else
      echo "The current date is not two days apart from the timestamp date."
      return 1
    fi
  else
    return 0
  fi
}

# Usage example
timestamp_file="$HOME/.restic/last_snapshot"
if check_two_days_apart "$timestamp_file"; then
    restic -r s3:s3.us-west-001.backblazeb2.com/maged-mac-backup-restic backup ~
    restic -r s3:s3.us-west-001.backblazeb2.com/maged-mac-backup-restic snapshots --json | jq -r '.[-1].time' > ~/.restic/last_snapshot
    restic -r s3:s3.us-west-001.backblazeb2.com/maged-mac-backup-restic forget --keep-last 3 --prune
    curl https://nosnch.in/eac3efde1a &> /dev/null
else
  echo "The current date is not two days apart from the timestamp in $timestamp_file."
fi
