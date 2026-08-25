pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.components
import qs.modules
import qs.config
import qs.services

Variants {
    model: Quickshell.screens
    delegate: Scope {
        id: scope

        property int borderThickness: Config.layout.borderWidth
        property bool audioOpen: Visibilities.audioScreen === scope.modelData

        required property ShellScreen modelData

        Exclusions {
            screen: scope.modelData
            bar: bar
            thickness: scope.borderThickness
        }

        StyledWindow {
            id: window
            name: "drawers"

            screen: scope.modelData

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            mask: Region {
                Region {
                    item: bar
                }
                Region {
                    item: scope.audioOpen ? audioFlyout : null
                }
            }

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: scope.audioOpen ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            Border {
                bar: bar
                // rounding: Config.layout.rounding.large
                rounding: 20
                thickness: scope.borderThickness
            }

            BarWrapper {
                id: bar
                screen: scope.modelData
            }

            Flyout {
                id: audioFlyout
                anchorItem: bar.audioButton
                shown: scope.audioOpen
                content: AudioPanel {}
            }

            HyprlandFocusGrab {
                active: scope.audioOpen
                windows: [window]
                onCleared: Visibilities.closeAudio()
            }
        }
    }
}
