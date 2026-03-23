pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick

JsonObject {
    property Radius radius: Radius {}
    property Spacing spacing: Spacing {}
    property Padding padding: Padding {}
    property Margin margin: Margin {}
    property Font font: Font {}

    component Radius: JsonObject {
        property int small: 3
        property int normal: 6
        property int large: 12
    }

    component Spacing: JsonObject {
        property int small: 6
        property int normal: 10
        property int large: 16
    }

    component Padding: JsonObject {
        property int small: 6
        property int normal: 10
        property int large: 16
    }

    component Margin: JsonObject {
        property int small: 4
        property int normal: 8
        property int large: 12
    }

    component Font: JsonObject {
        property string family: "NotoSans Nerd Font Propo"
        property int small: 8
        property int normal: 12
        property int large: 18
        property int icon: 20
    }
}
