import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

StyledWindow {
    id: previewRoot
    name: "color-preview"
    
    property int padding: 20

    // Set fixed boundaries for the window so the contents know when to scroll
    width: 700
    height: 600

    Rectangle {
        anchors.fill: parent
        color: Config.colors.background || "#121212"
        radius: 20
    }

    // Small help label
    Text {
        id: title
        text: "Omarchy Theme Preview"
        anchors.horizontalCenter: parent.horizontalCenter
        y: padding
        color: Config.colors.foreground || "white"
        font.pixelSize: 18
        font.weight: Font.Bold
        opacity: 0.7
    }

    // The scrollable container
    Flickable {
        id: scrollArea
        anchors.top: title.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: padding
        anchors.rightMargin: padding
        anchors.bottomMargin: padding
        
        // Tells the Flickable how much room it needs to scroll through
        contentHeight: grid.implicitHeight
        
        // Prevents the grid items from drawing over the title when scrolling up
        clip: true 

        // The 2-column grid
        GridLayout {
            id: grid
            columns: 2
            width: parent.width // Bind grid width to the Flickable's width
            rowSpacing: 10
            columnSpacing: 20

            Repeater {
                model: Object.entries(Config.colors)

                delegate: Rectangle {
                    property string colorName: modelData[0]
                    property color colorValue: modelData[1]
                    required property var modelData

                    // 1. Exclude keys ending in "Changed" 
                    // 2. Ensure the value is actually a color/object, not a function
                    visible: !colorName.endsWith("Changed") && 
                            !colorName.startsWith("_") && 
                            typeof(colorValue) !== "function"
                    
                    Layout.fillWidth: true
                    // Use preferredHeight in Layouts instead of height
                    Layout.preferredHeight: visible ? 50 : 0
                    color: "transparent" 

                    RowLayout {
                        anchors.fill: parent
                        spacing: 15

                        // Color Swatch
                        Rectangle {
                            Layout.fillHeight: true
                            implicitWidth: 80 // Made slightly smaller to fit 2 columns nicer
                            color: colorValue
                            radius: 6
                            border.color: Config.colors.foreground || "white"
                            border.width: 1
                            opacity: 0.9
                        }

                        // Labels
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                text: colorName
                                color: Config.colors.foreground || "white"
                                font.pixelSize: 14
                                font.family: "Monospace"
                                font.weight: Font.DemiBold
                            }

                            Text {
                                text: colorValue.toString()
                                color: Config.colors.foreground || "white"
                                font.pixelSize: 11
                                font.family: "Monospace"
                                opacity: 0.6
                            }
                        }
                    }
                }
            }
        }
    }
}
