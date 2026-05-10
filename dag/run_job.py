import json
from dagster import materialize
from dagster_assets import raw_data, features, load_status

if __name__ == '__main__':
    try:
        result = materialize([raw_data, features, load_status])
        print("Dagster materialize success:", result.success)
        print(json.dumps({"success": result.success}))
    except Exception as e:
        print("Dagster run failed:", e)
        print(json.dumps({"success": False, "error": str(e)}))
