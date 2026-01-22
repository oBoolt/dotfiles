pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.helpers
import qs.widgets

Scope {
    id: root
    property bool osdVisible: false
    property string icon
    property string value

    function showOSD(type: int, icon: int, value: string): void {
        root.icon = Icons.get(icon);
        root.value = value;

        root.osdVisible = true;
        hideTimer.restart();
    }

    IpcHandler {
        target: "osd"
        function showOSD(type: int, iconName: string, value: string): void {
            root.showOSD(type, Icons.getKey(iconName), value);
        }
    }

    Timer {
        id: hideTimer
        interval: Config.osd.hideTime
        onTriggered: root.osdVisible = false
    }

    LazyLoader {
        active: root.osdVisible

        PanelWindow {
            id: window
            implicitWidth: Config.osd.width
            implicitHeight: Config.osd.height
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

                    Text {
                        font.pixelSize: Appearance.font.icon
                        Layout.preferredHeight: Appearance.font.icon
                        Layout.preferredWidth: Appearance.font.icon
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        text: root.icon
                    }
                    Rectangle {
                        id: bar
                        Layout.fillWidth: true
                        Layout.preferredHeight: window.implicitHeight / 4
                        color: Colors.backgroundc
                        radius: Appearance.radius.normal / 2

                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            implicitWidth: parseInt(root.value) / 100 * parent.width
                            color: Colors.aqua
                            radius: Appearance.radius.normal / 2
                        }
                    }
                    Text {
                        text: root.value
                        font.pixelSize: 16
                        Layout.preferredWidth: parent.width / 6
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }
}
