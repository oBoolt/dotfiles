pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.utils
import qs.components
import qs.services
import qs.config

LazyLoader {
    active: Config.modules.controlcenter && States.showControlCenter

    PanelWindow {
        // TODO: only open in the screen that was clicked
        screen: States.currentScreen
        exclusiveZone: 0
        anchors {
            top: true
            right: true
        }

        margins {
            top: Appearance.margin.normal
            right: Appearance.margin.normal
        }

        implicitWidth: 480 * Config.scaleFactor[screen.name]
        implicitHeight: screen.height * 0.75
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: Colors.background
            radius: Appearance.radius.small

            StackView {
                id: stackView
                anchors.fill: parent
                initialItem: mainPage
            }
        }

        Component {
            id: mainPage
            Page {
                ColumnLayout {
                    anchors.margins: Appearance.margin.large
                    anchors.fill: parent
                    spacing: 16

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

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            hoverEnabled: true
                            icon: Icons.ApplicationExitSymbolic
                        }

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            hoverEnabled: true
                            icon: Icons.SystemLockScreenSymbolic
                            onClicked: States.sessionLocked = true
                        }

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            hoverEnabled: true
                            icon: Icons.SystemRebootSymbolic
                            onClicked: {
                                process.command.push(Config.controlcenter.commands.reboot);
                                process.running = true;
                            }
                        }

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            hoverEnabled: true
                            icon: Icons.SystemShutdownSymbolic
                            onClicked: {
                                process.command.push(Config.controlcenter.commands.poweroff);
                                process.running = true;
                            }
                        }
                    }

                    // Panels
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 75

                        RowLayout {
                            anchors.fill: parent
                            spacing: 16

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: Appearance.radius.large
                                color: Colors.foreground
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "black"
                            }
                        }
                    }

                    // Panels
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 75

                        RowLayout {
                            anchors.fill: parent
                            spacing: 16

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "black"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "black"
                            }
                        }
                    }

                    // Sliders
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 16

                            Slider {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                value: Audio.sink.volume

                                onMoved: {
                                    Audio.sink.setVolume(this.value);
                                }
                            }

                            Slider {
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
        }

        Component {
            id: second
            Page {
                Rectangle {
                    anchors.fill: parent
                    color: "black"

                    ColumnLayout {

                        Text {
                            text: Audio.sink.name
                        }
                        Text {
                            text: Audio.source.name
                        }

                        Rectangle {
                            implicitHeight: 2
                            Layout.fillWidth: true
                        }

                        Text {
                            text: "Sinks"
                        }
                        Repeater {
                            model: Audio.sinks
                            Text {
                                required property PwNode modelData
                                visible: Audio.sink.node != modelData
                                text: modelData.description

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Audio.setSink(parent.modelData)
                                }
                            }
                        }
                        Text {
                            text: "Sources"
                        }
                        Repeater {
                            model: Audio.sources
                            Text {
                                required property PwNode modelData
                                visible: Audio.source.node != modelData
                                text: modelData.description

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Audio.setSource(parent.modelData)
                                }
                            }
                        }
                    }

                    // Component.onCompleted: console.log(JSON.stringify(Pipewire.nodes, null, 2))
                }
            }
        }

        Process {
            id: process
            command: ["sh", "-c"]
        }
    }
}
