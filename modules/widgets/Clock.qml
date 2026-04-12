pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

// StyledRect {
Rectangle {
    id: wrapper

    color: Config.colors.accent
    radius: Config.structure.rounding.full

    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height
    // implicitWidth: 100
    // implicitHeight: 100

    ColumnLayout {
        id: col

        Text {
            id: id_text

            Layout.margins: 10

            color: Config.colors.background

            // text: "--\n--\n--\n--"
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
