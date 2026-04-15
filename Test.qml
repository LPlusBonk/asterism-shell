pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.components
import qs.config

StyledWindow {
    name: "test"
    implicitWidth: 400
    implicitHeight: 400
    color: "grey"
    anchors.right: true

    Item {
        anchors.fill: parent

        Rectangle {
            id: a
            anchors.left: parent.left
            anchors.top: parent.top
            implicitWidth: 200
            implicitHeight: 200
            anchors.margins: 50
            color: "red"
            radius: 20
            visible: false
            layer.enabled: true
        }

        Item {
            id: sum
            anchors.fill: parent

            layer.enabled: true

            Rectangle {
                id: b
                anchors.fill: parent
                color: "transparent"
                visible: false
                layer.enabled: true

                Rectangle {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left

                    implicitHeight: 200
                }
            }

            Rectangle {
                id: c
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                implicitWidth: 200
                implicitHeight: 200
                anchors.margins: 50
                color: "transparent"
                visible: false
                layer.enabled: true
                // Text {
                //     anchors.centerIn: parent
                //     text: "meow"
                //     font.pixelSize: 20
                // }
            }

            MultiEffect {
                id: x
                anchors.fill: b
                source: b

                maskEnabled: true
                maskSource: c
                maskInverted: true
            }

            MultiEffect {
                id: y
                anchors.fill: b
                source: c

                maskEnabled: true
                maskSource: b
                maskInverted: true
            }
            visible: false
        }

        MultiEffect {
            anchors.fill: a
            source: a

            maskEnabled: true
            maskSource: sum
        }
    }
}
