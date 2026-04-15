import tomllib
import json
import os
import sys

TOML_PATH = os.path.expanduser("~/.config/omarchy/current/theme/colors.toml")

def get_colors_json():
    try:
        with open(TOML_PATH, "rb") as f:
            colors = tomllib.load(f)
        # Return as JSON string to stdout
        print(json.dumps(colors))
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    get_colors_json()
