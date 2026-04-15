pragma ComponentBehavior: Bound
import Quickshell.Services.UPower
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.components
import qs.config

Item {
    id: root
    implicitHeight: 64 + 16
    Layout.fillWidth: true
    property int batteryPercentage: Math.round(UPower.displayDevice.percentage * 100)
    // property int batteryPercentage: 30
    property double threshMin: 0.5
    property double spreadMin: 1

    StyledRect {
        id: background
        anchors.fill: parent

        border.color: !UPower.onBattery || UPower.displayDevice.percentage > 0.2 ? Config.colors.accent : Config.colors.color9
        border.width: 2
        radius: Config.layout.rounding.full
    }

    Item {
        id: rendered
        anchors.fill: parent
        anchors.margins: 6

        Rectangle {
            id: fill
            anchors.fill: parent
            radius: Config.layout.rounding.full
            color: !UPower.onBattery || UPower.displayDevice.percentage > 0.2 ? Config.colors.accent : Config.colors.color9
            visible: false
            layer.enabled: true
        }

        Item {
            id: sum
            anchors.fill: parent
            layer.enabled: true

            Item {
                id: mask
                anchors.fill: parent
                layer.enabled: true
                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    implicitHeight: sum.height / 100 * root.batteryPercentage
                }
                visible: false
            }

            Item {
                id: charge
                anchors.fill: parent
                layer.enabled: true
                Column {
                    anchors.fill: parent
                    Loader {
                        id: chargeIcon
                        anchors.horizontalCenter: parent.horizontalCenter
                        sourceComponent: MaterialIcon {
                            text: {
                                if (!UPower.displayDevice.isLaptopBattery) {
                                    if (PowerProfiles.profile === PowerProfile.PowerSaver)
                                        return "energy_savings_leaf";
                                    if (PowerProfiles.profile === PowerProfile.Performance)
                                        return "rocket_launch";
                                    return "balance";
                                }

                                const perc = UPower.displayDevice.percentage;
                                const charging = [UPowerDeviceState.Charging, UPowerDeviceState.FullyCharged, UPowerDeviceState.PendingCharge].includes(UPower.displayDevice.state);
                                if (perc === 1)
                                    return charging ? "battery_charging_full" : "battery_full";
                                let level = Math.floor(perc * 7);
                                if (charging && (level === 4 || level === 1))
                                    level--;
                                return charging ? `battery_charging_${(level + 3) * 10}` : `battery_${level}_bar`;
                            }
                            font.pointSize: 24
                            // color: !UPower.onBattery || UPower.displayDevice.percentage > 0.2 ? root.colour : Colours.palette.m3error
                            fill: 1
                        }
                    }

                    Item {
                        implicitHeight: charge.height - chargeIcon.height - chargeText.height - 6
                        anchors.left: parent.left
                        anchors.right: parent.right
                    }

                    Text {
                        id: chargeText
                        text: root.batteryPercentage

                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 15
                    }
                }
                visible: false
                layer.smooth: true
            }

            MultiEffect {
                anchors.fill: sum
                source: mask

                maskEnabled: true
                maskSource: charge
                maskInverted: true
                maskThresholdMin: root.threshMin
                maskSpreadAtMin: root.spreadMin
            }

            MultiEffect {
                anchors.fill: sum
                source: charge

                maskEnabled: true
                maskSource: mask
                maskInverted: true
                // maskThresholdMin: root.threshMin
                // maskSpreadAtMin: root.spreadMin
            }

            layer.smooth: true
            visible: false
        }

        MultiEffect {
            anchors.fill: rendered
            source: fill

            // blur: 0
            // blurEnabled: true
            // blurMax: 1
            // blurMultiplier: 1

            maskEnabled: true
            maskSource: sum
            maskThresholdMin: root.threshMin
            maskSpreadAtMin: root.spreadMin
            // maskInverted: true
        }
    }
}
