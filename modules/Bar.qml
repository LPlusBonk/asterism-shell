pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.widgets
import qs.config

ColumnLayout {
    id: root

    property ShellScreen screen
    property int marg: Config.layout.padding.small
    property int spacer: Config.layout.borderWidth - marg

    property alias audioButton: audioButtonItem

    spacing: 0

    // implicitWidth: 40
    // anchors.left: parent.left
    // anchors.top: parent.top
    // anchors.bottom: parent.bottom
    // anchors.fill: parent

    Item {
        implicitHeight: root.spacer
    }

    OsIcon {
        Layout.margins: root.marg
        Layout.fillWidth: true
    }

    Workspaces {
        Layout.margins: root.marg
        screen: root.screen
    }

    Day {
        Layout.margins: root.marg
    }

    Item {
        Layout.fillHeight: true
    }

    AudioButton {
        id: audioButtonItem
        Layout.margins: root.marg
        screen: root.screen
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
