import QtQuick

import qs.appearance

Rectangle {
    id: root

    property bool active: false
    property bool transition: false
    property bool enabled: true
    property bool _lastActive: root.active

    color: active ? Colors.main : Colors.container
    radius: Appearance.radius.small
    opacity: enabled ? 1 : 0.75

    signal toggled

    onActiveChanged: {
        if (root.active) {
            indicator.anchors.left = undefined;
            indicator.anchors.right = root.right;
        } else {
            indicator.anchors.right = undefined;
            indicator.anchors.left = root.left;
        }

        if (root._lastActive == !root.active) {
            root.transition = false;
            root._lastActive = root.active;
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
        enabled: root.enabled && !root.transition
        cursorShape: !root.enabled ? Qt.ForbiddenCursor : root.transition ? Qt.WaitCursor : Qt.PointingHandCursor
        onClicked: {
            root.transition = true;
            root.toggled();
        }
    }
}
