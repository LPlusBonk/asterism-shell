pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.components
import qs.config
import qs.services

InteractiveButton {
    id: root

    required property ShellScreen screen

    readonly property bool active: Visibilities.audioScreen === root.screen

    Layout.fillWidth: true
    implicitHeight: width
    border.width: 2
    border.color: Config.colors.accent
    color: root.active ? Config.colors.accent : "transparent"

    onClicked: Visibilities.toggleAudio(root.screen)

    MaterialIcon {
        anchors.centerIn: parent
        text: Audio.muted ? "volume_off" : "volume_up"
        color: root.active ? Config.colors.background : Config.colors.accent
        fill: root.active ? 1 : 0

        Behavior on fill {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    }
}
