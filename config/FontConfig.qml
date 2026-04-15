pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
    property Family family: Family {}
    property Size size: Size {}
    component Family: JsonObject {
        property string mono: "CaskaydiaCove NF"
        property string clock: "Rubik"
        property string material: "Material Symbols Rounded"
    }
    component Size: JsonObject {
        property int extrasmall: 10
        property int small: 12
        property int smaller: 14
        property int medium: 16
        property int large: 24
    }
}
