import tomllib
import os

TOML_PATH = os.path.expanduser("~/.local/share/omarchy/themes/kanagawa/colors.toml")
OUTPUT_PATH = "./config/Colors.qml"

def generate_theme():
    try:
        with open(TOML_PATH, "rb") as f:
            colors = tomllib.load(f)

        qml_content = "pragma Singleton\nimport QtQuick\n\nQtObject {\n"
        for key, value in colors.items():
            # Standardizes tomllib keys to QML property names
            qml_content += f"    readonly property color {key}: \"{value}\"\n"
        qml_content += "}\n"

        with open(OUTPUT_PATH, "w") as f:
            f.write(qml_content)

    except Exception as e:
        print(f"Error generating theme: {e}")

if __name__ == "__main__":
    generate_theme()
