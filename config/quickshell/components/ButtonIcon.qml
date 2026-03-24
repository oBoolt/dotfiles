import QtQuick

import qs.config

Item {
    id: root
    required property int icon
    property bool enabled: true
    property color color: Colors.foreground
    property alias hoverEnabled: area.hoverEnabled

    signal clicked(MouseEvent mouse)
    signal entered
    signal exited

    Icon {
        id: iconItem
        anchors.fill: parent
        color: root.enabled ? root.color : Colors.gray
        icon: root.icon

        MouseArea {
            id: area
            enabled: root.enabled
            anchors.fill: parent
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: e => root.clicked(e)
            onEntered: root.entered()
            onExited: root.exited()
        }
    }
}
