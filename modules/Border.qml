pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

import qs.config

Item {
    id: root

    required property Item bar
    required property int thickness
    required property int rounding

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: Config.colors.background

        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            anchors.margins: root.thickness
            anchors.leftMargin: root.bar.implicitWidth
            radius: root.rounding
        }
    }
}
