pragma ComponentBehavior: Bound
import qs.config
import qs.components
import Quickshell.Widgets
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root

    Image {
        id: icon
        anchors.fill: parent
        anchors.margins: 4
        source: "/usr/share/pixmaps/archlinux-logo.svg"
        layer.enabled: true
        visible: false
        // layer.smooth: true
        // smooth: true
        // antialiasing: true
    }

    MultiEffect {
        id: decolored
        source: icon
        anchors.fill: icon
        brightness: 1
    }

    layer.enabled: true
    layer.smooth: true
    MultiEffect {
        source: decolored
        // source: icon
        anchors.fill: icon
        // brightness: 1
        colorization: 1
        colorizationColor: Config.colors.accent
    }

    implicitHeight: width
}
