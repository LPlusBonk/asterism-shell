pragma ComponentBehavior: Bound

import qs.components
import qs.config
import Quickshell
import QtQuick
import QtQuick.Effects

Item {
    id: root

    readonly property int padding: Math.max(Config.structure.padding.small, Config.structure.borderWidth)
    readonly property int contentWidth: Config.structure.barWidth + padding * 2

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left

    implicitWidth: contentWidth

    layer.enabled: true
    layer.effect: MultiEffect {
        id: effect

        // 2. THE INNER SHADOW LOGIC
        // We enable shadow, but we need to "trap" it.
        shadowEnabled: true
        shadowColor: "black"
        shadowOpacity: 0.7
        shadowBlur: 1.0

        // This makes the shadow "bleed" from the mask edge
        // back onto your border background.
        shadowHorizontalOffset: 0
        shadowVerticalOffset: 0

        // This ensures the shadow doesn't render
        // in the "hole" you cut out.
        autoPaddingEnabled: false
    }

    Loader {
        id: content
        anchors.fill: parent
        sourceComponent: Bar {
            id: b
            implicitWidth: 80
        }
        active: true
    }
}
