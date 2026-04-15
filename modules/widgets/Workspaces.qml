pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Widget {
    borderWidth: 2
    padding: 4
    borderColor: Config.colors.accent
    readonly property int numWorkspaces: 5

    Repeater {
        model: 10

        Rectangle {
            required property int index
            property var modelData: Hyprland.workspaces.values.find(w => w.id == index + 1)
            property bool ws: modelData != null
            property bool isActive: Hyprland.focusedWorkspace === modelData

            property color colActive: Config.colors.accent
            property color colInactive: Qt.darker(Config.colors.accent, 2)
            property color colEmpty: Qt.darker(Config.colors.accent, 4)

            Layout.fillWidth: true
            implicitHeight: width
            radius: Config.layout.rounding.full
            visible: (index + 1 < numWorkspaces) || isActive || ws
            color: isActive ? colActive : (ws ? colInactive : colEmpty)

            Text {
                anchors.centerIn: parent
                text: index + 1
                color: parent.isActive ? colEmpty : (parent.ws ? colActive : colInactive)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (index + 1))
            }
        }
    }
}
