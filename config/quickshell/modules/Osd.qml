pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.appearance
import qs.components
import qs.services

Item {
    id: root
    anchors.bottom: parent.bottom
    anchors.bottomMargin: parent.height * 0.1
    implicitWidth: 200
    implicitHeight: 50
    x: parent.width / 2 - width / 2

    Loader {
        anchors.fill: parent
        active: OsdManager.showOsd
        sourceComponent: Rectangle {
            anchors.fill: parent
            color: Colors.background
            radius: Appearance.radius.normal

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 18
                anchors.rightMargin: 18
                spacing: 12

                Icon {
                    Layout.preferredHeight: Appearance.font.icon
                    Layout.preferredWidth: Appearance.font.icon
                    icon: OsdManager.icon
                }

                Rectangle {
                    id: bar
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.implicitHeight / 4
                    color: Colors.container
                    radius: Appearance.radius.normal / 2

                    Rectangle {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        implicitWidth: OsdManager.value * parent.width
                        color: Colors.main
                        radius: Appearance.radius.normal / 2
                    }
                }
                Text {
                    text: Math.ceil(OsdManager.value * 100)
                    font.pixelSize: 16
                    Layout.preferredWidth: parent.width / 6
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
