pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config
import qs.services

Rectangle {
    id: root

    implicitWidth: 280
    implicitHeight: layout.height + Config.layout.padding.medium * 2
    radius: Config.layout.rounding.medium
    color: Config.colors.background

    ColumnLayout {
        id: layout

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: Config.layout.padding.medium
        spacing: Config.layout.padding.medium

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Audio"
            color: Config.colors.accent
            font.family: Config.font.family.mono
            font.pointSize: Config.font.size.medium
            font.weight: 900
        }

        Section {
            Layout.fillWidth: true
            title: "Output"
            icon: "volume_up"
            mutedIcon: "volume_off"
            muted: Audio.muted
            volume: Audio.volume
            devices: Audio.sinks
            currentId: Audio.sink?.id ?? -1
            onMuteToggleRequested: Audio.toggleMute()
            onVolumeRequested: v => Audio.setVolume(v)
            onDeviceSelected: node => Audio.setSink(node)
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: Config.colors.color8
        }

        Section {
            Layout.fillWidth: true
            title: "Input"
            icon: "mic"
            mutedIcon: "mic_off"
            muted: Audio.sourceMuted
            volume: Audio.sourceVolume
            devices: Audio.sources
            currentId: Audio.source?.id ?? -1
            onMuteToggleRequested: Audio.toggleSourceMute()
            onVolumeRequested: v => Audio.setSourceVolume(v)
            onDeviceSelected: node => Audio.setSource(node)
        }
    }

    component Section: ColumnLayout {
        id: section

        required property string title
        required property string icon
        required property string mutedIcon
        required property bool muted
        required property real volume
        required property var devices
        required property int currentId

        signal muteToggleRequested
        signal volumeRequested(real v)
        signal deviceSelected(var node)

        spacing: Config.layout.padding.small

        RowLayout {
            Layout.fillWidth: true
            spacing: Config.layout.padding.small

            Text {
                Layout.fillWidth: true
                text: section.title
                color: Config.colors.foreground
                font.family: Config.font.family.mono
                font.pointSize: Config.font.size.small
                font.weight: 900
            }

            InteractiveButton {
                id: muteButton

                implicitWidth: 28
                implicitHeight: 28
                color: section.muted ? Config.colors.color9 : "transparent"
                border.width: 2
                border.color: section.muted ? Config.colors.color9 : Config.colors.accent
                hoverScale: 1.1
                pressScale: 0.88

                onClicked: section.muteToggleRequested()

                MaterialIcon {
                    anchors.centerIn: parent
                    text: section.muted ? section.mutedIcon : section.icon
                    color: section.muted ? Config.colors.background : Config.colors.accent
                    fill: section.muted ? 1 : 0
                    font.pointSize: Config.font.size.small

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }

        Item {
            id: slider

            Layout.fillWidth: true
            implicitHeight: 20
            opacity: section.muted ? 0.4 : 1

            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Rectangle {
                id: track
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: sliderArea.containsMouse || sliderArea.pressed ? 6 : 4
                radius: height / 2
                color: Config.colors.color8

                Behavior on height {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Rectangle {
                id: fill
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: track.left
                width: track.width * Math.max(0, Math.min(1, section.volume))
                height: track.height
                radius: height / 2
                color: Config.colors.accent

                Behavior on width {
                    enabled: !sliderArea.pressed
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Rectangle {
                id: thumb
                x: fill.width - width / 2
                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: sliderArea.pressed ? 16 : 12
                implicitHeight: implicitWidth
                radius: Config.layout.rounding.full
                color: Config.colors.accent
                scale: sliderArea.containsMouse || sliderArea.pressed ? 1 : 0

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutBack
                    }
                }
            }

            MouseArea {
                id: sliderArea
                anchors.fill: parent
                hoverEnabled: true
                onPressed: mouse => section.volumeRequested(Math.max(0, Math.min(1, mouse.x / width)))
                onPositionChanged: mouse => {
                    if (pressed)
                        section.volumeRequested(Math.max(0, Math.min(1, mouse.x / width)));
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2
            visible: section.devices.length > 1

            Repeater {
                model: section.devices

                Rectangle {
                    id: deviceRow
                    required property var modelData

                    readonly property bool current: deviceRow.modelData.id === section.currentId

                    Layout.fillWidth: true
                    implicitHeight: 24
                    radius: Config.layout.rounding.small
                    color: deviceRow.current ? Config.colors.selection_background : deviceArea.containsMouse ? Config.colors.color8 : "transparent"
                    scale: deviceArea.pressed ? 0.97 : 1

                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on scale {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutCubic
                        }
                    }

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: Config.layout.padding.small
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - Config.layout.padding.medium
                        text: deviceRow.modelData.description || deviceRow.modelData.name
                        color: deviceRow.current ? Config.colors.selection_foreground : Config.colors.foreground
                        font.family: Config.font.family.mono
                        font.pointSize: Config.font.size.extrasmall
                        elide: Text.ElideRight

                        Behavior on color {
                            ColorAnimation {
                                duration: 120
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    MouseArea {
                        id: deviceArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: section.deviceSelected(deviceRow.modelData)
                    }
                }
            }
        }
    }
}
