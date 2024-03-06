# ml_models/dbthouse/hho_develop/churn_prediction/79135d6d-1fb9-42ec-93bf-975510628de8.pkl.gz
import sys
from joblib import load
import pandas as pd


def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["scikit-learn", "joblib", "pandas"],
        snowflake_warehouse = "PARK"
    )

    model_id = dbt.ref("churn_prediction").to_pandas().sort_values(by="timestamp", ascending=False)["id"].values[0]

    session.file.get(
        f"@dbthouse.develop.ml_models/{dbt.this.database}/{dbt.this.schema}/churn_prediction/{model_id}.pkl.gz",
        '/tmp/mdl/'
    )
    model = load(f"/tmp/mdl/{model_id}.pkl.gz")

    stillingshistorikk_person = dbt.ref("stillingshistorikk_person").to_pandas().dropna()

    df = stillingshistorikk_person.copy()

    y = df['SLUTTET_STILLING']
    X = df.drop(columns=['SLUTTET_STILLING'])

    categorical_columns = X.select_dtypes(include=['object']).columns
    X_ohe = pd.get_dummies(X, columns=categorical_columns, drop_first=True)

    y_pred = model.predict(X_ohe)

    stillingshistorikk_person['predicted_churn'] = y_pred

    return stillingshistorikk_person



