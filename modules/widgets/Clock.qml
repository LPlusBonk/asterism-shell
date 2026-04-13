pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

StyledRect {
    id: wrapper

    color: Config.colors.accent
    radius: Config.structure.rounding.full

    implicitHeight: childrenRect.height + Config.structure.padding.small * 2
    Layout.fillWidth: true

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Config.structure.padding.small

        Text {
            id: id_text

            Layout.alignment: Qt.AlignHCenter

            color: Config.colors.background

            text: Qt.formatDateTime(new Date(), "hh\nmm\nss\nA")
            font.pointSize: Config.font.size.small
            font.weight: 900

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: parent.text = Qt.formatDateTime(new Date(), "hh\nmm\nss\nA")
            }
        }
    }
}
