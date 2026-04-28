import QtQuick
import Qt5Compat.GraphicalEffects

import Quickshell
import Quickshell.Widgets

import qs.utils
import qs.config

Item {
    id: root
    property int icon: -1
    property string iconString
    property alias color: colorOverlay.color
    property alias implicitSize: image.implicitSize
    property bool disableColor: false
    clip: true

    IconImage {
        id: image
        anchors.centerIn: parent
        implicitSize: parent.height * 0.75
        source: (root.icon != -1) ? Icons.get(root.icon) : (root.iconString != null || root.iconString != "") ? Quickshell.iconPath(root.iconString) : "unknown"

        ColorOverlay {
            id: colorOverlay
            visible: !root.disableColor
            anchors.fill: parent
            source: parent
            color: Colors.foreground
        }
    }
}
