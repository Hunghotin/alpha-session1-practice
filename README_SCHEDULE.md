Scheduling setup (local)

Files added:
- `dagster_assets.py` — asset definitions and `run_materialize()` helper.
- `run_job.py` — runs `run_materialize()` and prints a JSON result.
- `run_daily.sh` — shell wrapper that activates `course311`, runs the job, and shows a macOS notification.
- `install_cron.sh` — installs a user crontab entry to run `run_daily.sh` daily at 21:30 Asia/Shanghai.

Install steps (run once):

1. Ensure `course311` conda env exists and has `dagster` installed.

2. Make scripts executable:

```bash
chmod +x run_daily.sh install_cron.sh
```

3. Install crontab entry (this will append an entry if missing):

```bash
./install_cron.sh
```

Notes:
- Cron line sets `TZ=Asia/Shanghai` so the task runs at 21:30 Shanghai time. Cron uses system cron interpretation; the `TZ` env var attempts to force timezone for that job.
- The `run_daily.sh` uses `conda activate course311`. If your conda is installed in a non-standard location, modify the script to source the correct `conda.sh` path.
- `run_daily.sh` writes logs to `run_daily.log` and a JSON result to `run_job.out.json` in the same folder.

To test manually (inside this repo folder) and stay in the `course311` env:

```bash
# activate env first
conda activate course311
./run_daily.sh
cat run_job.out.json
tail -n 100 run_daily.log
```
