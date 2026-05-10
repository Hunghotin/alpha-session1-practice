#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
HERE="$(pwd)"

# Activate conda environment `course311` (adjust path if needed)
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
  source "$HOME/miniconda3/etc/profile.d/conda.sh"
elif [ -f "/opt/miniconda/etc/profile.d/conda.sh" ]; then
  source "/opt/miniconda/etc/profile.d/conda.sh"
else
  source "$(conda info --base 2>/dev/null)/etc/profile.d/conda.sh" || true
fi

conda activate course311 || echo "Warning: could not activate course311"

# Run the job and capture JSON output
OUTFILE="$HERE/run_job.out.json"
python ./run_job.py > "$OUTFILE" 2>&1 || true

# macOS notification (optional)
if command -v osascript >/dev/null 2>&1; then
  osascript -e 'display notification "Dag run finished" with title "Dagster Test"'
fi
