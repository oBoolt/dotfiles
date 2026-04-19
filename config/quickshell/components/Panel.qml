import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Rectangle {
    id: page
    property int icon: 0
    property string title
    property string text
    property bool enabled: false

    signal clicked(MouseEvent mouse)

    radius: Appearance.radius.large
    color: page.enabled ? Colors.main : Colors.backgroundMuted

    RowLayout {
        anchors.fill: parent
        anchors.margins: Appearance.padding.normal
        spacing: Appearance.spacing.small

        Icon {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            color: page.enabled ? Colors.background : Colors.foreground
            icon: page.icon
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 0

            Text {
                Layout.fillWidth: true
                Layout.fillHeight: !page.enabled
                verticalAlignment: Text.AlignVCenter
                color: page.enabled ? Colors.background : Colors.foreground
                font.pixelSize: page.enabled ? Appearance.font.large : Appearance.font.large * 1.25
                text: page.title
            }
            Text {
                visible: page.enabled
                Layout.fillWidth: true
                font.bold: false
                verticalAlignment: Text.AlignVCenter
                color: page.enabled ? Colors.background : Colors.foreground
                elide: Text.ElideRight
                text: page.text
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: mouse => page.clicked(mouse)
    }
}
