import sys
from joblib import load
import pandas as pd


def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["scikit-learn", "joblib", "pandas"],
        snowflake_warehouse = "PARK"
    )

    model_id = dbt.ref("walmart_weekly_sales_train").to_pandas().sort_values(by="timestamp", ascending=False)["id"].values[0]

    session.file.get(
        f"@dbthouse.develop.ml_models/{dbt.this.database}/{dbt.this.schema}/walmart_weekly_sales_train/{model_id}.pkl.gz",
        '/tmp/mdl/'
    )
    model = load(f"/tmp/mdl/{model_id}.pkl.gz")

    walmart_sales = dbt.ref("walmart_sales").to_pandas().dropna()

    df = walmart_sales.copy()

    y = df['WEEKLY_SALES']
    X = df.drop(columns=['WEEKLY_SALES', "SALES_WEEK_START"])


    y_pred = model.predict(X)

    walmart_sales['predicted_sales'] = y_pred

    return walmart_sales



