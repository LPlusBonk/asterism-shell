// qmllint disable uncreatable-type
import Quickshell
import Quickshell.Wayland

PanelWindow {
    required property string name

    WlrLayershell.namespace: `asterism-${name}`
    color: "transparent"
}
