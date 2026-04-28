import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Rectangle {
    id: root
    property int icon: 0
    property string title
    property string text
    property bool found: false
    final property bool enabled: false
    readonly property bool _enabled: root.found && root.enabled

    readonly property color textColor: _enabled ? Colors.topMain : Colors.foreground

    signal clicked(MouseEvent mouse)

    radius: Appearance.radius.large
    // color: root.enabled ? Colors.main : Colors.backgroundMuted
    color: !found ? Colors.containerMute : enabled ? Colors.main : Colors.container

    RowLayout {
        anchors.fill: parent
        anchors.margins: Appearance.padding.normal
        spacing: Appearance.spacing.small

        Icon {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            color: root.textColor
            icon: root.icon
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 0

            Text {
                Layout.fillWidth: true
                Layout.fillHeight: !root.enabled
                verticalAlignment: Text.AlignVCenter
                color: root.textColor
                font.pixelSize: root.enabled ? Appearance.font.large : Appearance.font.large * 1.25
                text: root.title
            }
            Text {
                visible: root.enabled
                Layout.fillWidth: true
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                // color: root.enabled ? Colors.background : Colors.foreground
                color: root.textColor
                elide: Text.ElideRight
                text: root.text
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: !root.found ? Qt.ForbiddenCursor : Qt.PointingHandCursor
        onClicked: mouse => {
            if (!root.found)
                return;
            root.clicked(mouse);
        }
    }
}
