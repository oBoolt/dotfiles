import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell.Widgets
import qs.utils
import qs.config

Item {
    id: root
    required property int icon
    property alias color: colorOverlay.color
    property alias implicitSize: image.implicitSize

    IconImage {
        id: image
        anchors.centerIn: parent
        implicitSize: parent.height * 0.7
        source: Icons.get(root.icon)

        ColorOverlay {
            id: colorOverlay
            anchors.fill: parent
            source: parent
            color: Colors.foreground
        }
    }
}
