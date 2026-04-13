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
        anchors.fill: parent

        layer.enabled: true
        layer.effect: MultiEffect {
            // Shadow Properties
            shadowEnabled: true
            shadowColor: "black"
            shadowBlur: 1.0     // Adjust for "softness"
            shadowOpacity: 0.7
            shadowHorizontalOffset: 0
            shadowVerticalOffset: 0

            // The Secret Sauce:
            // We mask the shadow using the same mask so it only stays on the border.
            maskEnabled: true
            maskSource: mask
            maskInverted: true
            autoPaddingEnabled: false
        }

        // We use the 'mask' item itself as the source for the shadow.
        // Because the mask is the "hole," the shadow will radiate from the hole's edges.
        ShaderEffectSource {
            anchors.fill: parent
            sourceItem: mask
            live: true
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
