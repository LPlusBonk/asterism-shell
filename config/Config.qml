pragma Singleton
import QtQuick // When un-commented, breaks the project
import Quickshell
import Quickshell.Io

QtObject {
    readonly property LayoutConfig layout: LayoutConfig {}
    readonly property FontConfig font: FontConfig {}
    readonly property Colors colors: Colors {}

    property FileView themeWatcher: FileView {
        id: themeWatcher
        path: Qt.resolvedUrl("/home/bonk/.config/omarchy/current/theme/colors.toml")
        // path: Qt.resolvedUrl("/home/user/.config/omarchy/current/theme/colors.toml")
        // path: "/home/user/.config/omarchy/current/theme/colors.toml"
        // path: "~/.config/omarchy/current/theme/colors.toml"
        watchChanges: true

        onFileChanged: {
            console.log("File Updated");
            colorLoader.running = true;
        }
    }

    Component.onCompleted: {
        colorLoader.running = true;
    }

    property Process colorLoader: Process {
        id: colorLoader
        command: ["python3", "update-colors.py"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const newColors = JSON.parse(text);
                    for (let key in newColors) {
                        if (Config.colors.hasOwnProperty(key)) {
                            Config.colors[key] = newColors[key];
                        }
                    }
                    console.log("Color scheme updated.");
                } catch (e) {
                    console.error("Failed to parse JSON from Python:", e);
                }
            }
        }
    }
}
