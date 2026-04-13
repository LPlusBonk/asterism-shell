import qs.config

Text {
    property real fill
    property int grade: false ? 0 : -25

    font.family: Config.font.family.material
    font.pointSize: Config.font.size.medium
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            opsz: fontInfo.pixelSize,
            wght: fontInfo.weight
        })
}
