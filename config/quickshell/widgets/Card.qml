import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.widgets
import qs.helpers

Item {
    id: root
    required property int icon
    property color color: Colors.foreground
    property alias value: value.text
    property bool background: true

    implicitWidth: childrenRect.width
    implicitHeight: Appearance.font.icon + Appearance.padding.small

    Rectangle {
        id: background
        implicitHeight: parent.implicitHeight
        implicitWidth: root.value != "" ? items.implicitWidth + Appearance.padding.small * 2 : parent.implicitHeight
        color: root.background ? Colors.backgroundc : "transparent"
        radius: Appearance.radius.small

        RowLayout {
            id: items
            anchors.centerIn: parent
            implicitHeight: root.implicitHeight
            spacing: Appearance.spacing.small

            Text {
                Layout.fillWidth: true
                font.pixelSize: Appearance.font.icon - 2
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: root.color
                text: Icons.get(root.icon)
            }

            Text {
                id: value
                visible: root.value != ""
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Rectangle {
            anchors.bottom: parent.bottom
            implicitWidth: background.implicitWidth
            implicitHeight: 1.5
            color: root.color
        }
    }
}
