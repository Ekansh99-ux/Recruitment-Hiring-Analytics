from pathlib import Path
from getpass import getpass
from urllib.parse import quote_plus

import pandas as pd
from sqlalchemy import create_engine


# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR / "data"


# PostgreSQL connection details
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "recruitment_analysis"
DB_USER = "postgres"


def create_db_engine():
    """Create a SQLAlchemy connection to PostgreSQL."""
    password = getpass("Enter PostgreSQL password: ")

    connection_url = (
        f"postgresql+psycopg2://{DB_USER}:{quote_plus(password)}"
        f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )

    return create_engine(connection_url)


def load_csv_to_postgresql(engine, filename, table_name):
    """Load a CSV file into a PostgreSQL table."""
    file_path = DATA_DIR / filename

    if not file_path.exists():
        print(f"File not found: {file_path}")
        return

    df = pd.read_csv(file_path)

    df.to_sql(
        table_name,
        engine,
        if_exists="replace",
        index=False
    )

    print(f"Loaded {filename} -> {table_name} ({len(df)} rows)")


def main():
    engine = create_db_engine()

    tables = {
        "sources.csv": "sources",
        "recruiters.csv": "recruiters",
        "jobs.csv": "jobs",
        "candidates.csv": "candidates",
        "applications.csv": "applications",
        "interviews.csv": "interviews",
        "offers.csv": "offers",
        "hires.csv": "hires",
    }

    for filename, table_name in tables.items():
        load_csv_to_postgresql(engine, filename, table_name)

    print("\nAll recruitment data loaded successfully.")


if __name__ == "__main__":
    main()
