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
        hoverEnabled: true
        border.width: 1
        font.pixelSize: height * 0.25
        font.capitalization: Font.AllUppercase
    }

    WlSessionLockSurface {
        id: surface

        function sendPassword(): void {
            LoginManager.login(inputField.text);
            inputField.clear();
        }

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
                        border.color: Colors.danger
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
            Item {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: surface.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: Appearance.font.large * 2
                implicitWidth: (surface.width / 6)

                // Background
                Rectangle {
                    anchors.fill: parent
                    color: Colors.background
                    opacity: 0.5
                }

                // Indicator
                Rectangle {
                    id: indicatorItem
                    anchors.bottom: parent.bottom
                    implicitWidth: parent.width
                    implicitHeight: 2
                    color: LoginManager.result == "Failed" ? Colors.critical : Colors.main
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.bottomMargin: indicatorItem.implicitHeight

                    TextInput {
                        id: inputField
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.leftMargin: parent.width * 0.05
                        focus: true
                        clip: true
                        echoMode: TextInput.Password
                        passwordCharacter: "◆"
                        verticalAlignment: TextInput.AlignVCenter
                        onAccepted: surface.sendPassword()
                        color: Colors.foreground

                        Text {
                            anchors.fill: parent
                            visible: !parent.text
                            verticalAlignment: Text.AlignVCenter
                            opacity: 0.75
                            font: parent.font
                            text: "Logging in Bolt..."
                        }
                    }

                    Button {
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        Layout.margins: parent.width * 0.01
                        icon: Icons.GoNextSymbolic
                        hoverEnabled: true
                        onClicked: surface.sendPassword()
                    }
                }
            }
        }
    }
}
