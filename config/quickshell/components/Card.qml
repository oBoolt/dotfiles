import QtQuick

import qs.components
import qs.utils
import qs.config

Item {
    id: card
    required property int icon
    property bool hover: false
    property alias color: icon.color

    signal clicked(MouseEvent mouse)

    implicitWidth: Appearance.font.icon
    implicitHeight: width

    Icon {
        id: icon
        anchors.fill: parent
        icon: card.icon
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            bg.visible = true;
        }
        onExited: {
            bg.visible = false;
        }
        onClicked: e => card.clicked(e)

        Rectangle {
            id: bg
            visible: false
            opacity: 0.1
            anchors.fill: parent
            radius: Appearance.radius.small
        }
    }
}
