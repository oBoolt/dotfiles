import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Notifications

import qs.appearance
import qs.components
import qs.services
import qs.utils
import qs.modules
import qs.types

Page {
    id: root

    // Quick actions
    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height * 0.05

        Icon {
            Layout.preferredHeight: Appearance.font.icon
            Layout.preferredWidth: Appearance.font.icon
            icon: Icons.AvatarDefaultSymbolic
        }

        Text {
            font.pixelSize: Appearance.font.large * 0.8
            text: System.user + "@" + System.hostname
        }

        Item {
            Layout.fillWidth: true
        }

        Button {
            Layout.preferredWidth: Appearance.font.icon
            Layout.preferredHeight: Appearance.font.icon
            hoverEnabled: true
            icon: Icons.ApplicationExitSymbolic
            onClicked: System.logout()
        }

        Button {
            Layout.preferredWidth: Appearance.font.icon
            Layout.preferredHeight: Appearance.font.icon
            hoverEnabled: true
            icon: Icons.SystemLockScreenSymbolic
            onClicked: ModulesState.lockSession()
        }

        Button {
            Layout.preferredWidth: Appearance.font.icon
            Layout.preferredHeight: Appearance.font.icon
            hoverEnabled: true
            icon: Icons.SystemRebootSymbolic
            onClicked: System.reboot()
        }

        Button {
            Layout.preferredWidth: Appearance.font.icon
            Layout.preferredHeight: Appearance.font.icon
            hoverEnabled: true
            icon: Icons.SystemShutdownSymbolic
            onClicked: System.poweroff()
        }
    }

    // Panels
    ColumnLayout {
        Layout.fillWidth: true
        // Layout.fillHeight: true
        Layout.maximumHeight: (parent.height / 5) + (spacing)
        spacing: 16

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 16

            Panel {
                Layout.fillWidth: true
                Layout.fillHeight: true

                enabled: NetworkManager.connected
                found: NetworkManager.found
                title: "Network"
                text: NetworkManager.currentConnection == null ? (NetworkManager.currentDevice?.name ?? "Unknown") : NetworkManager.currentConnection.name
                icon: NetworkManager.icon
                onClicked: root.push(Page.Network)
            }

            Panel {
                Layout.fillWidth: true
                Layout.fillHeight: true

                enabled: BluetoothManager.connectedDevices.length > 0
                found: BluetoothManager.currentAdapter !== null
                title: "Bluetooth"
                text: BluetoothManager.connectedDevices[0]?.name ?? ""
                icon: Icons.BluetoothSymbolic
                onClicked: root.push(Page.Bluetooth)
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 16

            Panel {
                Layout.fillWidth: true
                Layout.fillHeight: true

                enabled: true
                found: true
                icon: Icons.AudioVolumeHighSymbolic
                title: "Audio"
                text: Audio.sink.name

                onClicked: root.push(Page.Audio)
            }

            Panel {
                Layout.fillWidth: true
                Layout.fillHeight: true

                enabled: false
                title: "Placeholder"
            }
        }
    }

    // Usage
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height * 0.1

        RowLayout {
            anchors.fill: parent

            RadialUsageIndicator {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                Layout.alignment: Qt.AlignCenter
                percentage: System.usage.cpu.percentage
            }
            RadialUsageIndicator {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                Layout.alignment: Qt.AlignCenter
                percentage: System.usage.mem.percentage
            }
            RadialUsageIndicator {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                Layout.alignment: Qt.AlignCenter
                percentage: System.usage.gpu.percentage
            }
            RadialUsageIndicator {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                Layout.alignment: Qt.AlignCenter
                percentage: 0.5
            }
        }
    }

    // Sliders
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: parent.height * 0.15

        ColumnLayout {
            anchors.fill: parent
            spacing: Appearance.spacing.large

            IconSlider {
                Layout.fillHeight: true
                Layout.fillWidth: true
                value: Audio.sink.volume
                enabled: Audio.sink != null
                icon: Audio.sink.icon

                onMoved: Audio.sink.setVolume(this.value)
                onIconClicked: Audio.sink.toggleMute()
            }

            IconSlider {
                Layout.fillHeight: true
                Layout.fillWidth: true
                value: Brightness.percentage
                // enabled: Brightness.valid
                from: 0.01
                icon: 0

                onMoved: Brightness.set(this.value)
            }
        }
    }

    // Notification
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: Colors.containerMute
        radius: Appearance.radius.normal
        clip: true

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Appearance.margin.large
            spacing: Appearance.spacing.normal

            RowLayout {
                Text {
                    text: "Notifications"
                }
                Item {
                    Layout.fillWidth: true
                }
                Button {
                    Layout.preferredWidth: Appearance.font.icon
                    Layout.preferredHeight: width
                    icon: Icons.UserTrashSymbolic
                    background.hover: true
                    disabledColor: Colors.foregroundMute
                    enabled: NotificationHistory.notifications.length > 0
                    onClicked: NotificationHistory.clear()
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: Colors.foreground
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: Appearance.spacing.large
                clip: true

                model: ScriptModel {
                    values: [...NotificationHistory.notifications].reverse()
                }
                delegate: Rectangle {
                    id: not
                    required property SimpleNotification modelData
                    radius: Appearance.radius.small
                    width: ListView.view.width
                    height: ListView.view.height * 0.4
                    color: Colors.container

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: NotificationHistory.remove(not.modelData.date)
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors {
                            leftMargin: anchors.margins + 2
                            rightMargin: anchors.margins + 2
                            margins: Appearance.margin.normal - 2
                        }
                        // Layout.alignment: Qt.AlignTop
                        // Layout.fillWidth: true
                        // Layout.fillHeight: true
                        spacing: Appearance.spacing.small - 2

                        RowLayout {
                            spacing: Appearance.spacing.small
                            Layout.fillWidth: true
                            Layout.maximumHeight: Appearance.font.large

                            Text {
                                Layout.alignment: Qt.AlignVCenter
                                text: not.modelData.summary
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text {
                                Layout.alignment: Qt.AlignVCenter
                                visible: text !== ""
                                text: not.modelData.appName
                                font.bold: false
                                font.pixelSize: Appearance.font.small
                                verticalAlignment: Text.AlignVCenter
                                color: Colors.foregroundMute
                            }
                            Item {
                                Layout.fillWidth: true
                            }
                            Text {
                                Layout.alignment: Qt.AlignVCenter
                                text: Qt.formatDateTime(not.modelData.date, "hh:mm dd/MM")
                                font.pixelSize: Appearance.font.small
                                verticalAlignment: Text.AlignVCenter
                                color: Colors.foregroundMute
                            }
                        }

                        Text {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            visible: text !== ""
                            text: not.modelData.body
                            font.bold: false
                            elide: Text.ElideRight
                            wrapMode: Text.Wrap
                        }
                    }
                }
            }
        }
    }
}
