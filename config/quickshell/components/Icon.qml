import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell.Widgets
import qs.utils

Item {
    id: root
    required property int icon
    property alias color: colorOverlay.color

    IconImage {
        anchors.centerIn: parent
        implicitSize: parent.height * 0.8
        source: Icons.get(root.icon)

        ColorOverlay {
            id: colorOverlay
            anchors.fill: parent
            source: parent
        }
    }
}
