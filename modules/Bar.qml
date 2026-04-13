pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.modules.widgets
import qs.config

ColumnLayout {
    id: root

    property int marg: Config.structure.padding.small
    property int spacer: Config.structure.borderWidth - marg

    spacing: 0

    // implicitWidth: 40
    // anchors.left: parent.left
    // anchors.top: parent.top
    // anchors.bottom: parent.bottom
    // anchors.fill: parent

    Item {
        implicitHeight: root.spacer
    }

    Workspaces {
        Layout.margins: root.marg
    }

    Item {
        Layout.fillHeight: true
    }

    Battery {
        Layout.margins: root.marg
    }

    Clock {
        Layout.margins: root.marg
    }

    Item {
        implicitHeight: root.spacer
    }
}
