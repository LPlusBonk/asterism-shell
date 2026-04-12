pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.components

Scope {
    id: root

    required property ShellScreen screen
    required property Item bar
    required property int thickness

    ExclusionZone {
        anchors.left: true
        exclusiveZone: root.bar.implicitWidth
    }

    ExclusionZone {
        anchors.top: true
    }

    ExclusionZone {
        anchors.right: true
    }

    ExclusionZone {
        anchors.bottom: true
    }

    component ExclusionZone: StyledWindow {
        screen: root.screen
        name: "border-exclusion"
        exclusiveZone: root.thickness
        mask: Region {}
        implicitWidth: 1
        implicitHeight: 1
    }
}
