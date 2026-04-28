import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Rectangle {
    id: root
    property int icon: 0
    property string title
    property string text
    final property bool enabled: false
    property bool found: false

    signal clicked(MouseEvent mouse)

    radius: Appearance.radius.large
    color: root.enabled ? Colors.main : Colors.backgroundMuted

    RowLayout {
        anchors.fill: parent
        anchors.margins: Appearance.padding.normal
        spacing: Appearance.spacing.small

        Icon {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            color: root.enabled ? Colors.background : Colors.foreground
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
                color: root.enabled ? Colors.background : Colors.foreground
                font.pixelSize: root.enabled ? Appearance.font.large : Appearance.font.large * 1.25
                text: root.title
            }
            Text {
                visible: root.enabled
                Layout.fillWidth: true
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                color: root.enabled ? Colors.background : Colors.foreground
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
