pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Item {
    id: root
    Layout.fillWidth: true
    implicitHeight: mainLayout.height + padding * 2

    default property alias content: mainLayout.data
    property alias layout: mainLayout
    property int borderWidth: 0
    property int padding: 0
    property color backgroundColor: "transparent"
    property color borderColor: "transparent"

    StyledRect {
        id: background

        color: root.backgroundColor
        border.color: root.borderColor
        border.width: root.borderWidth
        radius: Config.layout.rounding.full
        anchors.fill: parent
    }

    ColumnLayout {
        id: mainLayout
        anchors.margins: root.padding
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
