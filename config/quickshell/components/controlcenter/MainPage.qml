import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.services
import qs.utils

Page {
    id: root

    component Panel: Rectangle {
        id: page
        property int icon: 0
        property string title
        property string text
        property bool enabled: false

        signal clicked(MouseEvent mouse)

        radius: Appearance.radius.large
        color: page.enabled ? Colors.main : Colors.backgroundMuted

        RowLayout {
            anchors.fill: parent
            anchors.margins: Appearance.padding.normal
            spacing: Appearance.spacing.small

            Icon {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                color: page.enabled ? Colors.background : Colors.foreground
                icon: page.icon
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 0

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: !page.enabled
                    verticalAlignment: Text.AlignVCenter
                    color: page.enabled ? Colors.background : Colors.foreground
                    font.pixelSize: page.enabled ? Appearance.font.large : Appearance.font.large * 1.25
                    text: page.title
                }
                Text {
                    visible: page.enabled
                    Layout.fillWidth: true
                    font.bold: false
                    verticalAlignment: Text.AlignVCenter
                    color: page.enabled ? Colors.background : Colors.foreground
                    elide: Text.ElideRight
                    text: page.text
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: mouse => page.clicked(mouse)
        }
    }

    ColumnLayout {
        anchors.margins: Appearance.margin.large
        anchors.fill: parent
        spacing: Appearance.spacing.large

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
                    icon: Audio.sink.icon
                    title: "Audio"
                    text: Audio.sink.name

                    onClicked: root.push(Page.Audio)
                }

                Panel {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    enabled: false
                    title: "System"
                    onClicked: root.push(Page.SystemInfo)
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
}
