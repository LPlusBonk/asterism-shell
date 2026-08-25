pragma ComponentBehavior: Bound
import QtQuick

// Generic anchored popup: fades/scales in next to anchorItem when shown,
// growing from the edge closest to it. Purely presentational; callers own
// the open/closed state and any outside-click dismissal.
Item {
    id: root

    required property bool shown
    property Item anchorItem
    property int gap: 8
    property Component content

    readonly property point anchorPoint: root.anchorItem ? root.anchorItem.mapToItem(root.parent, root.anchorItem.width, root.anchorItem.height / 2) : Qt.point(0, 0)

    x: anchorPoint.x + gap
    y: anchorPoint.y - height / 2

    implicitWidth: loader.item?.implicitWidth ?? 0
    implicitHeight: loader.item?.implicitHeight ?? 0
    width: implicitWidth
    height: implicitHeight

    visible: opacity > 0.01
    opacity: root.shown ? 1 : 0
    scale: root.shown ? 1 : 0.85
    transformOrigin: Item.Left

    Behavior on opacity {
        NumberAnimation {
            duration: 140
            easing.type: Easing.OutCubic
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutBack
            easing.overshoot: 1.15
        }
    }

    Loader {
        id: loader
        anchors.fill: parent
        active: true
        sourceComponent: root.content
    }
}
