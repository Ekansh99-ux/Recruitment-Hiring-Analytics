from pathlib import Path
import pandas as pd


DATA_DIR = Path(__file__).resolve().parent.parent / "data"


def load_recruitment_data():
    """Load all recruitment CSV files from the data directory."""
    files = {
        "candidates": "candidates.csv",
        "jobs": "jobs.csv",
        "applications": "applications.csv",
        "interviews": "interviews.csv",
        "offers": "offers.csv",
        "hires": "hires.csv",
        "recruiters": "recruiters.csv",
        "sources": "sources.csv",
    }

    data = {}

    for name, filename in files.items():
        path = DATA_DIR / filename

        if path.exists():
            data[name] = pd.read_csv(path)
            print(f"Loaded {name}: {len(data[name])} rows")
        else:
            print(f"File not found: {filename}")

    return data


if __name__ == "__main__":
    recruitment_data = load_recruitment_data()

    print("\nRecruitment data loading completed.")
    print(f"Tables loaded: {len(recruitment_data)}")
