pragma ComponentBehavior: Bound

import qs.components
import qs.config
import Quickshell
import QtQuick

Item {
    id: root

    readonly property int padding: Math.max(Config.structure.padding.small, Config.structure.borderWidth)
    readonly property int contentWidth: Config.structure.barWidth + padding * 2

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left

    implicitWidth: contentWidth

    Loader {
        id: content
        anchors.fill: parent
        sourceComponent: Bar {
            id: b
            implicitWidth: 80
        }
        active: true
    }
}
