pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell.Wayland

import qs.utils
import qs.config
import qs.services
import qs.components

WlSessionLock {
    id: lock
    locked: States.sessionLocked

    WlSessionLockSurface {
        id: surface

        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Qt.resolvedUrl(Config.wallpaper[surface.screen.name])

            Rectangle {
                anchors.fill: parent
                color: Colors.background
                opacity: 0.5
            }
        }

        Item {
            anchors.fill: parent
            anchors.margins: surface.height * 0.05

            // Actions
            RowLayout {
                anchors.top: parent.top
                anchors.left: parent.left
                spacing: Appearance.spacing.normal

                Button {
                    Layout.preferredHeight: Appearance.font.icon * 1.5
                    Layout.preferredWidth: 200
                    icon: Icons.SystemShutdownSymbolic
                    background.visible: true
                    background.color: Colors.background
                    hoverEnabled: true
                    text: "Shutdown"
                    onClicked: System.poweroff()
                }
                Button {
                    Layout.preferredWidth: Appearance.font.icon * 1.5
                    Layout.preferredHeight: Appearance.font.icon * 1.5
                    icon: Icons.SystemRebootSymbolic
                    background.visible: true
                    background.color: Colors.background
                    hoverEnabled: true
                    onClicked: System.reboot()
                }
                Button {
                    Layout.preferredWidth: Appearance.font.icon * 1.5
                    Layout.preferredHeight: Appearance.font.icon * 1.5
                    icon: Icons.ApplicationExitSymbolic
                    background.visible: true
                    background.color: Colors.background
                    hoverEnabled: true
                    onClicked: System.logout()
                }
            }
            // Clock
            Item {
                anchors.top: parent.top
                anchors.right: parent.right
                implicitWidth: (surface.width / 5)
                implicitHeight: (surface.height / 5)

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Text {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: parent.width
                        fontSizeMode: Text.Fit
                        renderType: Text.QtRendering
                        renderTypeQuality: Text.HighRenderTypeQuality
                        text: Time.hours + ":" + Time.minutes
                    }
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.fillWidth: true
                        Layout.preferredHeight: parent.height / 4
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: parent.width
                        fontSizeMode: Text.VerticalFit
                        font.bold: false
                        color: Colors.main
                        text: Qt.formatDate(Time.date, "dddd, MMM dd")
                    }
                }
            }
            // Input
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                implicitHeight: Appearance.font.large * 1.5
                implicitWidth: (surface.width / 4)

                TextInput {
                    anchors.fill: parent
                    focus: true
                    echoMode: TextInput.Password
                    passwordCharacter: "*"
                    onAccepted: {
                        LoginManager.login(this.text);
                        this.clear();
                    }
                }
            }
        }
    }
}
