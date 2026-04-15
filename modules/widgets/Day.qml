pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Widget {
    Loader {
        Layout.alignment: Qt.AlignHCenter

        sourceComponent: MaterialIcon {
            text: "calendar_month"
            color: Config.colors.accent
        }
    }

    Text {
        id: id_text

        Layout.alignment: Qt.AlignHCenter

        color: Config.colors.accent
        text: Qt.formatDateTime(new Date(), "dd\nMM")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: parent.text = Qt.formatDateTime(new Date(), "dd\nMM")
        }
    }
}
