pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.components
import qs.modules
import qs.config

Variants {
    model: Quickshell.screens
    Scope {
        id: scope

        property int borderThickness: Config.layout.borderWidth

        required property ShellScreen modelData

        Exclusions {
            screen: scope.modelData
            bar: bar
            thickness: scope.borderThickness
        }

        StyledWindow {
            name: "drawers"

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            mask: Region {
                item: bar
            }

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            // WlrLayershell.keyboardFocus: visibilities.launcher || visibilities.session ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            Border {
                bar: bar
                // rounding: Config.layout.rounding.large
                rounding: 20
                thickness: scope.borderThickness
            }

            BarWrapper {
                id: bar
            }
        }
    }
}
