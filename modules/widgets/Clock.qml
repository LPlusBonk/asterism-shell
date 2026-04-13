pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Item {
    Layout.fillWidth: true
    implicitHeight: content.height + content.anchors.margins * 2

    StyledRect {
        id: wrapper

        color: Config.colors.accent
        radius: Config.structure.rounding.full
        anchors.fill: content
    }

    ColumnLayout {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right

        Text {
            id: id_text

            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: Config.structure.padding.medium
            Layout.topMargin: Config.structure.padding.medium

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
