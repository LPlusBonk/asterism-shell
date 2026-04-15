pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

IconImage {
    id: root

    // required property color color
    //
    // asynchronous: true
    //
    // layer.enabled: true
    // layer.effect: MultiEffect {
    //     property color sourceColor: "black"
    //     sourceColor: analyser.dominantColour
    //     colorizationColor: root.color
    //
    //     colorization: 1
    //     brightness: 1 - sourceColor.hslLightness
    // }

    // ImageAnalyser {
    //     id: analyser
    //
    //     sourceItem: root.source
    // }
}
