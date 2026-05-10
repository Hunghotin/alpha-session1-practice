from dagster import asset, RetryPolicy

@asset(
    description="Extract raw market data",
    retry_policy=RetryPolicy(max_retries=3, delay=60),
)
def raw_data():
    return [1, 2, 3, 4]

@asset
def features(raw_data):
    return [x * 10 for x in raw_data]

@asset
def load_status(features):
    print(f"Dagster loaded features: {features}")
    return True

# Helper for local/test runs
if __name__ == '__main__':
    from dagster import materialize
    materialize([raw_data, features, load_status])
