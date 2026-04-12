pragma ComponentBehavior: Bound

Rectangle {
    color: Config.colors.accent
    implicitWidth: id_text.implicitWidth + 2 * Config.layout.padding.medium
    implicitHeight: id_text.implicitHeight + 2 * Config.layout.padding.medium
    radius: Config.layout.rounding.full

    Text {
        id: id_text
        anchors.centerIn: parent
        color: Config.colors.background

        text: "--\n--\n--\n--"
        font.pointSize: Config.font.size.smaller
        font.weight: 900

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: parent.text = Qt.formatDateTime(new Date(), "hh\nmm\nss\nA")
        }
    }
}
