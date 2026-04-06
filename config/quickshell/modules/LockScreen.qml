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

    component ActionButton: Button {
        background.visible: true
        background.color: Colors.background
        background.opacity: 0.5
        background.radius: 0
        border.width: 1
        font.capitalization: Font.AllUppercase
    }

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
            Item {
                anchors.top: parent.top
                anchors.left: parent.left
                implicitWidth: (surface.width / 5)
                implicitHeight: (surface.height * 0.05)

                RowLayout {
                    anchors.fill: parent
                    spacing: Appearance.spacing.normal

                    ActionButton {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: "power"
                        onClicked: System.poweroff()
                    }
                    ActionButton {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: "restart"
                        onClicked: System.reboot()
                    }
                    ActionButton {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: "lougout"
                        onClicked: System.logout()
                    }
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
