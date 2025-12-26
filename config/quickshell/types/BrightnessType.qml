import QtQuick

QtObject {
    property int max: 1
    property int current: 1
    property real percentage: current / max
    readonly property real step: 0.05
}
