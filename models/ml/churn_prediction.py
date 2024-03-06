from sklearn.model_selection import train_test_split
import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
import datetime
import uuid
import joblib

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["scikit-learn", "joblib", "pandas"],
        snowflake_warehouse = "PARK"
    )
    
    stillingshistorikk_person = dbt.ref("stillingshistorikk_person").to_pandas().dropna()

    X = stillingshistorikk_person.drop(columns=['SLUTTET_STILLING'])
    y = stillingshistorikk_person['SLUTTET_STILLING']
    categorical_columns = X.select_dtypes(include=['object']).columns
    X_ohe = pd.get_dummies(X, columns=categorical_columns, drop_first=True)

    X_train, X_test, y_train, y_test = train_test_split(X_ohe, y, test_size=0.2, random_state=42)

    model = DecisionTreeClassifier()
    model.fit(X_train, y_train)


    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    now = datetime.datetime.utcnow()
    id = str(uuid.uuid4())


    accuracy_df = pd.DataFrame({"id": [id], "accuracy": [accuracy], "timestamp": [now]})

    stage = f"@dbthouse.develop.ml_models/{dbt.this.database}/{dbt.this.schema}/{dbt.this.identifier}/"
    model_loc = f"tmp/{id}.pkl"
    joblib.dump(model, model_loc)
    session.file.put(model_loc, stage)

    return accuracy_df