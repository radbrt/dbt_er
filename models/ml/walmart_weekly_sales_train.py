
from sklearn.model_selection import train_test_split
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
import datetime
import uuid
import joblib

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["scikit-learn", "joblib", "pandas"],
        snowflake_warehouse = "PARK"
    )
    
    stillingshistorikk_person = dbt.ref("walmart_sales").to_pandas().dropna()

    X = stillingshistorikk_person.drop(columns=['WEEKLY_SALES', "SALES_WEEK_START"])
    y = stillingshistorikk_person['WEEKLY_SALES']
    # categorical_columns = X.select_dtypes(include=['object']).columns
    # X_ohe = pd.get_dummies(X, columns=categorical_columns, drop_first=True)

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    model = LinearRegression()
    model.fit(X_train, y_train)


    y_pred = model.predict(X_test)
    mse = mean_squared_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)
    now = datetime.datetime.utcnow()
    id = str(uuid.uuid4())
    database = dbt.this.database
    schema = dbt.this.schema
    identifier = dbt.this.identifier

    accuracy_df = pd.DataFrame({
        "id": [id], 
        "mse": [mse], 
        "r2": [r2], 
        "timestamp": [now],
        "database": [database],
        "schema": [schema],
        "identifier": [identifier]
        })

    stage = f"@dbthouse.develop.ml_models/{database}/{schema}/{identifier}/"
    model_loc = f"tmp/{id}.pkl"
    joblib.dump(model, model_loc)
    session.file.put(model_loc, stage)

    return accuracy_df