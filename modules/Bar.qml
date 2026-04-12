pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.modules.widgets

ColumnLayout {
    id: root

    implicitWidth: 100
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    Item {
        Layout.fillHeight: true
    }

    Clock {
        Layout.margins: 10
    }
}
