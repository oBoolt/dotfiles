pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
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
            source: Qt.resolvedUrl(Quickshell.env("XDG_CONFIG_HOME") + "/wallpapers/hk-4-3840_2160.jpg")

            Rectangle {
                anchors.fill: parent
                color: Colors.background
                opacity: 0.5
            }
        }
        // Clock
        Item {
            anchors.margins: Appearance.margin.large
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            implicitWidth: (surface.width / 4)
            implicitHeight: (surface.height / 4)

            Rectangle {
                anchors.fill: parent
                color: Colors.background
                opacity: 0.75
                radius: Appearance.radius.large
            }
            Text {
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.65
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: Time.hours + ":" + Time.minutes
            }
        }
        Rectangle {
            anchors.centerIn: parent
            implicitWidth: (parent.width / 3)
            implicitHeight: (parent.height / 3)
            color: Colors.backgroundMuted
            radius: Appearance.radius.large
            ColumnLayout {
                Rectangle {
                    implicitHeight: 20
                    implicitWidth: 100
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
        // Actions
        RowLayout {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: Appearance.margin.large
            spacing: Appearance.spacing.normal
            layoutDirection: Qt.RightToLeft

            ButtonIcon {
                Layout.preferredWidth: Appearance.font.icon * 1.5
                Layout.preferredHeight: Appearance.font.icon * 1.5
                icon: Icons.SystemShutdownSymbolic
                background: true
                backgroundColor: Colors.background
                backgroundOpacity: 0.75
                hoverEnabled: true
                onClicked: System.poweroff()
            }
            ButtonIcon {
                Layout.preferredWidth: Appearance.font.icon * 1.5
                Layout.preferredHeight: Appearance.font.icon * 1.5
                icon: Icons.SystemRebootSymbolic
                background: true
                backgroundColor: Colors.background
                backgroundOpacity: 0.75
                hoverEnabled: true
                onClicked: System.reboot()
            }
            ButtonIcon {
                Layout.preferredWidth: Appearance.font.icon * 1.5
                Layout.preferredHeight: Appearance.font.icon * 1.5
                icon: Icons.ApplicationExitSymbolic
                background: true
                backgroundColor: Colors.background
                backgroundOpacity: 0.75
                hoverEnabled: true
                onClicked: System.logout()
            }
        }
    }
}
