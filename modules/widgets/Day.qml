pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Item {
    Layout.fillWidth: true
    // implicitHeight: content.height + content.anchors.margins * 2
    implicitHeight: content.height

    // StyledRect {
    //     id: wrapper
    //
    //     color: Config.colors.accent
    //     radius: Config.layout.rounding.full
    //     anchors.fill: content
    // }

    ColumnLayout {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        Loader {
            anchors.horizontalCenter: parent.horizontalCenter

            sourceComponent: MaterialIcon {
                text: "calendar_month"
                color: Config.colors.accent
            }
        }

        Text {
            id: id_text

            Layout.alignment: Qt.AlignHCenter
            // Layout.bottomMargin: Config.layout.padding.medium
            // Layout.topMargin: Config.layout.padding.medium

            color: Config.colors.accent

            text: Qt.formatDateTime(new Date(), "dd\nMM")
            font.pointSize: Config.font.size.small
            font.weight: 900

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: parent.text = Qt.formatDateTime(new Date(), "dd\nMM")
            }
        }
    }
}
