pragma Singleton

import Quickshell
import QtQuick

Singleton {
    component Radius: QtObject {
        property int small: 3
        property int normal: 6
        property int large: 12
    }

    component Spacing: QtObject {
        property int small: 6
        property int normal: 10
        property int large: 12
    }

    component Padding: QtObject {
        property int small: 6
        property int normal: 10
        property int large: 16
    }

    component Margin: QtObject {
        property int small: 4
        property int normal: 8
        property int large: 12
    }

    component Font: QtObject {
        property string family: "NotoSans Nerd Font Propo"
        property int small: normal - 2
        property int normal: 12
        property int large: normal + 6
        property int icon: normal + 8
    }

    component Animations: QtObject {
        property bool enabled: true
    }

    readonly property Radius radius: Radius {}
    readonly property Spacing spacing: Spacing {}
    readonly property Padding padding: Padding {}
    readonly property Margin margin: Margin {}
    readonly property Font font: Font {}
    readonly property Animations animations: Animations {}
}
