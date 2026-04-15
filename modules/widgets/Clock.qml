pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Widget {
    backgroundColor: Config.colors.accent

    Text {
        id: id_text

        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: Config.layout.padding.medium
        Layout.topMargin: Config.layout.padding.medium

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
