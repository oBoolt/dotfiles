import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.components
import qs.appearance

Rectangle {
    id: root
    property alias value: slider.value
    property alias from: slider.from
    property alias icon: iconItem.icon
    property bool enabled: false

    signal moved
    signal iconClicked

    color: Colors.containerMute
    radius: Appearance.radius.normal

    RowLayout {
        anchors.fill: parent
        anchors.topMargin: 4
        anchors.bottomMargin: anchors.topMargin
        anchors.leftMargin: anchors.topMargin * 2
        anchors.rightMargin: anchors.leftMargin
        spacing: Appearance.spacing.normal

        Icon {
            id: iconItem
            Layout.fillHeight: true
            Layout.preferredWidth: height
            implicitSize: height * 0.75

            MouseArea {
                enabled: root.enabled
                anchors.fill: parent
                cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: root.iconClicked()
            }
        }

        Slider {
            id: slider
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: parent.anchors.topMargin
            Layout.bottomMargin: Layout.topMargin

            enabled: root.enabled
            from: 0
            to: root.enabled ? 1 : 0
            stepSize: 0.01
            handle: Item {}
            background: Rectangle {
                color: Colors.container
                radius: root.radius
                // radius: root.radius / 2

                Rectangle {
                    color: Colors.main
                    radius: parent.radius
                    implicitWidth: slider.visualPosition * parent.width
                    implicitHeight: parent.height
                }
            }

            onMoved: {
                if (!root.enabled)
                    return;
                root.moved();
            }
        }
    }
}
