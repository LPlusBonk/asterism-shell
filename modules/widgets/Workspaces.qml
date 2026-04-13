pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Item {
    implicitHeight: column.height + column.anchors.margins * 2
    Layout.fillWidth: true

    StyledRect {
        id: background

        border.color: Config.colors.accent
        border.width: 2
        radius: Config.structure.rounding.full

        anchors.fill: parent
    }

    ColumnLayout {
        id: column

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        // anchors.bottom: parent.bottom
        anchors.margins: 6
        spacing: 4

        Repeater {
            model: 5

            Rectangle {
                id: workspace

                Layout.fillWidth: true
                implicitHeight: width
                // Layout.margins: 6

                required property int index
                property bool ws: Boolean(Hyprland.workspaces.values.find(w => w.id === index + 1))
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                property color colActive: Config.colors.accent
                property color colInactive: Qt.darker(Config.colors.accent, 2)
                property color colEmpty: Qt.darker(Config.colors.accent, 4)

                // color: "red"
                color: workspace.isActive ? colActive : (workspace.ws ? colInactive : colEmpty)
                radius: Config.structure.rounding.full

                Text {
                    anchors.centerIn: parent
                    text: workspace.index + 1
                    font.pointSize: Config.font.size.small
                    font.weight: 900
                    color: workspace.isActive ? colEmpty : (workspace.ws ? colActive : colInactive)
                }

                MouseArea {
                    // required property int index
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (workspace.index + 1))
                }
            }
        }
    }
}
