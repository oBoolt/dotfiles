import QtQuick

import qs.config

Item {
    id: root
    property bool enabled: true
    property color color: Colors.foreground
    property alias icon: icon.icon

    signal clicked(MouseEvent mouse)
    Icon {
        id: icon
        anchors.fill: parent
        color: root.enabled ? root.color : Colors.gray

        MouseArea {
            enabled: root.enabled
            anchors.fill: parent
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: e => root.clicked(e)
        }
    }
}
