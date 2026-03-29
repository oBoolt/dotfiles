import QtQuick

import qs.config

Item {
    id: root
    required property int icon
    property bool enabled: true
    property color color: Colors.foreground
    property alias hoverEnabled: area.hoverEnabled
    property alias background: backgroundItem.visible
    property alias backgroundColor: backgroundItem.color
    property alias backgroundOpacity: backgroundItem.opacity
    readonly property bool react: color == Colors.foreground || color == Colors.foregroundMuted

    signal clicked(MouseEvent mouse)
    signal entered
    signal exited

    Rectangle {
        id: backgroundItem
        visible: false
        anchors.fill: parent
        radius: Appearance.radius.small
        color: Colors.foregroundMuted
    }

    Icon {
        id: iconItem
        anchors.fill: parent
        color: root.enabled ? root.color : Colors.disabled
        icon: root.icon

        MouseArea {
            id: area
            enabled: root.enabled
            anchors.fill: parent
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
            onClicked: e => root.clicked(e)
            onEntered: {
                if (root.react)
                    root.color = Colors.foregroundMuted;
                root.entered();
            }
            onExited: {
                if (root.react)
                    root.color = Colors.foreground;
                root.exited();
            }
        }
    }
}
