import QtQuick

import qs.config

Rectangle {
    id: root
    property bool active: false
    color: active ? Colors.main : Colors.container
    radius: Appearance.radius.small

    signal toggled

    onActiveChanged: {
        if (root.active) {
            indicator.anchors.left = undefined;
            indicator.anchors.right = root.right;
        } else {
            indicator.anchors.right = undefined;
            indicator.anchors.left = root.left;
        }
    }

    Rectangle {
        id: indicator
        color: root.active ? Colors.topMain : Colors.containerMute
        radius: parent.radius
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: !root.active ? parent.left : undefined
        anchors.margins: 2

        implicitWidth: parent.height - anchors.margins * 2
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.toggled()
    }
}
