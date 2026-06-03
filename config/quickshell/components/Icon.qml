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
    property bool rawSource: false
    property alias color: colorOverlay.color
    property int implicitSize: (height * 0.7) % 2 === 0 ? height * 0.7 : height * 0.7 + 1

    property bool disableColor: false
    clip: true

    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: root.implicitSize
        implicitHeight: width

        IconImage {
            id: image
            anchors.fill: parent
            // implicitSize: parent.height * 0.75
            source: (root.icon != -1) ? Icons.get(root.icon) : ((root.iconString != null || root.iconString != "") && !root.rawSource) ? Quickshell.iconPath(root.iconString) : root.iconString

            ColorOverlay {
                id: colorOverlay
                visible: !root.disableColor
                anchors.fill: parent
                source: parent
                color: Colors.foreground
            }
        }
    }
}
