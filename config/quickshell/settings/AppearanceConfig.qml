pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick

JsonObject {
    id: root
    property real scaleFactor: 1
    property Radius radius: Radius {}
    property Spacing spacing: Spacing {}
    property Padding padding: Padding {}
    property Margin margin: Margin {}
    property Font font: Font {}

    component Radius: JsonObject {
        property int small: 3 * root.scaleFactor
        property int normal: 6 * root.scaleFactor
        property int large: 12 * root.scaleFactor
    }

    component Spacing: JsonObject {
        property int small: 6 * root.scaleFactor
        property int normal: 10 * root.scaleFactor
        property int large: 16 * root.scaleFactor
    }

    component Padding: JsonObject {
        property int small: 6 * root.scaleFactor
        property int normal: 10 * root.scaleFactor
        property int large: 16 * root.scaleFactor
    }

    component Margin: JsonObject {
        property int small: 4 * root.scaleFactor
        property int normal: 8 * root.scaleFactor
        property int large: 12 * root.scaleFactor
    }

    component Font: JsonObject {
        property string family: "NotoSans Nerd Font Propo"
        property int small: 8 * root.scaleFactor
        property int normal: 14 * root.scaleFactor
        property int large: 20 * root.scaleFactor
        property int icon: 20 * root.scaleFactor
    }
}
