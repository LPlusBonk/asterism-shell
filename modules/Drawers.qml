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

        property int borderThickness: Config.structure.padding.small

        required property ShellScreen modelData

        Exclusions {
            screen: scope.modelData
            bar: bar
            thickness: borderThickness
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
            WlrLayershell.keyboardFocus: visibilities.launcher || visibilities.session ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            Border {
                bar: bar
                rounding: Config.structure.rounding.medium
                thickness: borderThickness
            }

            Bar {
                id: bar
            }
        }
    }
}
