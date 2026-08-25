import QtQuick

import qs.config

// Reusable circular interactive control: provides hover/press scale
// feedback and animated color transitions. Consumers bind color/
// border.color to their own state and add child content (icon/text)
// as usual; handle activation via onClicked.
Rectangle {
    id: root

    readonly property bool hovered: mouseArea.containsMouse
    readonly property bool pressed: mouseArea.pressed

    property real hoverScale: 1.08
    property real pressScale: 0.9
    property int colorAnimationDuration: 150
    property int scaleAnimationDuration: 120

    signal clicked

    radius: Config.layout.rounding.full
    scale: root.pressed ? root.pressScale : root.hovered ? root.hoverScale : 1

    Behavior on scale {
        NumberAnimation {
            duration: root.scaleAnimationDuration
            easing.type: Easing.OutCubic
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: root.colorAnimationDuration
            easing.type: Easing.OutCubic
        }
    }

    Behavior on border.color {
        ColorAnimation {
            duration: root.colorAnimationDuration
            easing.type: Easing.OutCubic
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
