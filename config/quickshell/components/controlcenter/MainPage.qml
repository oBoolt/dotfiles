import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.services
import qs.utils

Page {
    id: root

    // Quick actions
    RowLayout {
        Layout.fillWidth: true

        Icon {
            Layout.preferredHeight: Appearance.font.icon
            Layout.preferredWidth: Appearance.font.icon
            icon: Icons.AvatarDefaultSymbolic
        }

        Text {
            font.pixelSize: Appearance.font.large * 0.8
            text: "bolt@quacker"
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
            onClicked: States.lockSession()
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
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 60

        RowLayout {
            anchors.fill: parent
            spacing: 16

            Panel {
                Layout.fillWidth: true
                Layout.fillHeight: true

                enabled: true
                icon: Icons.AudioVolumeHighSymbolic
                title: "Audio"
                text: Audio.sink.name

                onClicked: root.push(Page.Audio)
            }

            Panel {
                Layout.fillWidth: true
                Layout.fillHeight: true

                enabled: BluetoothManager.enabled
                title: "Bluetooth"
                text: BluetoothManager.connectedDevices[0]?.name ?? ""
                icon: Icons.BluetoothSymbolic
                onClicked: root.push(Page.Bluetooth)
            }
        }
    }

    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 60

        RowLayout {
            anchors.fill: parent
            spacing: 16

            Panel {
                Layout.fillWidth: true
                Layout.fillHeight: true

                enabled: false
                title: "Placeholder"
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
        Layout.preferredHeight: 50

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
                percentage: System.usage.cpu.percentage
            }
            RadialUsageIndicator {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                Layout.alignment: Qt.AlignCenter
                percentage: System.usage.cpu.percentage
            }
        }
    }

    // Sliders
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 150

        ColumnLayout {
            anchors.fill: parent
            spacing: Appearance.spacing.large

            IconSlider {
                Layout.fillHeight: true
                Layout.fillWidth: true
                value: Audio.sink.volume

                onMoved: {
                    Audio.sink.setVolume(this.value);
                }
            }

            IconSlider {
                Layout.fillHeight: true
                Layout.fillWidth: true
                value: Brightness.percentage
                from: 0.01

                onMoved: {
                    let current = Brightness.max * this.value;
                    Brightness.set(current);
                }
            }
        }
    }

    // Notification
    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "red"
    }
}
