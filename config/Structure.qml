pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
    id: root
    property Padding padding: Padding {}
    property Rounding rounding: Rounding {}
    property int barWidth: 40
    property int borderWidth: padding.small

    component Padding: JsonObject {
        property int verysmall: 4
        property int small: 8
        property int medium: 16
        property int large: 24
        property int verylarge: 32
    }

    component Rounding: JsonObject {
        property int small: root.padding.small
        property int medium: root.padding.medium
        property int large: root.padding.verylarge
        property int full: 10000
    }
}
