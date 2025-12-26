import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.widgets.common
import qs.helpers

Item {
    id: root
    required property int icon
    property color color: Colors.foreground
    property alias value: value.text
    property bool background: true

    implicitWidth: childrenRect.width
    implicitHeight: Variables.iconSize + Variables.cardPadding

    Rectangle {
        id: background
        implicitHeight: parent.implicitHeight
        implicitWidth: root.value != "" ? items.implicitWidth + Variables.cardPadding * 2 : parent.implicitHeight
        color: root.background ? Colors.backgroundc : "transparent"
        radius: Variables.cardRadius

        RowLayout {
            id: items
            anchors.centerIn: parent
            implicitHeight: root.implicitHeight
            spacing: Variables.cardSpacing

            Text {
                Layout.fillWidth: true
                font.pixelSize: Variables.iconSize - 2
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
