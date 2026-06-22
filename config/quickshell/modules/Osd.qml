pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import qs.config
import qs.utils
import qs.components
import qs.services

LazyLoader {
    active: OsdManager.showOsd

    PanelWindow {
        id: window
        screen: States.currentScreen
        implicitWidth: 200
        implicitHeight: 50
        anchors.bottom: true
        margins.bottom: screen.height / 7
        exclusiveZone: 0
        color: "transparent"
        mask: Region {}

        Rectangle {
            anchors.fill: parent
            color: Colors.background
            radius: Appearance.radius.normal

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 18
                    rightMargin: 18
                }
                spacing: 12

                Icon {
                    Layout.preferredHeight: Appearance.font.icon
                    Layout.preferredWidth: Appearance.font.icon
                    icon: OsdManager.icon
                }
                Rectangle {
                    id: bar
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.implicitHeight / 4
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
                    text: parseInt(OsdManager.value * 100)
                    font.pixelSize: 16
                    Layout.preferredWidth: parent.width / 6
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
