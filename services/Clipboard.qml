import Quickshell.Io

Process {
    id: cliphistList
    command: ["cliphist", "list"]
    stdout: StdioCollector {
        onStreamFinished: {
            // text.trim() → split into lines → render as your own list
        }
    }
}

// on selection, re-copy the chosen entry back to the live clipboard:
Process {
    command: ["sh", "-c", "cliphist decode <<< '" + selectedLine + "' | wl-copy"]
}
