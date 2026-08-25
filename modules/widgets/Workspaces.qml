pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Widget {
    id: root
    borderWidth: 2
    padding: 4
    borderColor: Config.colors.accent
    readonly property int numWorkspaces: 5

    property ShellScreen screen
    property var hyprlandMonitor: screen ? (Hyprland.monitors.values.find(m => m.name === screen.name) ?? null) : null

    Repeater {
        model: 10

        InteractiveButton {
            id: background
            required property int index

            property var monitor: root.hyprlandMonitor
            property int numWs: root.numWorkspaces

            property var modelData: Hyprland.workspaces.values.find(w => w.id == index + 1)
            property bool ws: modelData != null
            // Hyprland keeps active workspaces in the list even with no windows; check via toplevels
            property bool hasWindows: ws && Hyprland.toplevels.values.some(t => t.workspace?.id === modelData.id)
            // Compare by name to avoid object identity mismatches across bindings
            property bool isOtherMonitor: ws && monitor != null && modelData.monitor?.name !== monitor.name
            // Active workspace of this widget's monitor
            property bool isActiveHere: !isOtherMonitor && (monitor != null ? (monitor.activeWorkspace != null && monitor.activeWorkspace.id == index + 1) : (Hyprland.focusedWorkspace === modelData))
            // Whether this monitor currently holds global focus
            property bool thisMonitorFocused: monitor == null || (Hyprland.focusedWorkspace != null && Hyprland.focusedWorkspace.monitor?.name === monitor.name)

            property color colActive: Config.colors.accent
            property color colInactive: Qt.darker(Config.colors.accent, 2)
            property color colEmpty: Qt.darker(Config.colors.accent, 4)

            // fill: accent if this monitor is focused+active; filled if owned with windows; bare otherwise
            color: isActiveHere && thisMonitorFocused ? colActive : hasWindows && !isOtherMonitor ? colInactive : colEmpty

            // inside border: only when workspace has windows (empty = no indicator)
            property bool showBorder: (isActiveHere && !thisMonitorFocused) || (hasWindows && isOtherMonitor)
            property color borderCol: isActiveHere ? colActive : colInactive

            Layout.fillWidth: true
            implicitHeight: width
            visible: (index + 1 < numWs) || isActiveHere || ws
            hoverScale: 1.12
            pressScale: 0.9

            onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = ${background.index + 1}})`)

            Rectangle {
                anchors.fill: parent
                anchors.margins: 0
                radius: Math.max(0, parent.radius - 2)
                color: "transparent"
                border.width: parent.showBorder ? 2 : 0
                border.color: parent.showBorder ? parent.borderCol : "transparent"

                Behavior on border.color {
                    ColorAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                text: background.index + 1
                // text is light on dark (focused active) or dim on bare (empty/foreign)
                color: parent.isActiveHere && parent.thisMonitorFocused ? parent.colEmpty : parent.hasWindows && !parent.isOtherMonitor ? parent.colActive : parent.colInactive

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
}
