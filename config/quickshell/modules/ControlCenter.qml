import Quickshell
import Quickshell.Io

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
            bottom: true
            right: true
        }

        margins {
            top: Appearance.margin.normal
            bottom: Appearance.margin.normal
            right: Appearance.margin.normal
        }

        implicitWidth: 480 * Config.scaleFactor[screen.name]
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

                    RowLayout {
                        Layout.fillWidth: true

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
                            icon: Icons.SystemLockScreenSymbolic
                        }

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            icon: Icons.ApplicationExitSymbolic
                        }

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            icon: 0
                        }

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            icon: Icons.SystemShutdownSymbolic
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100

                        RowLayout {
                            anchors.fill: parent
                            spacing: 16

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "black"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        process.command.push(Config.controlcenter.commands.poweroff);
                                        process.running = true;
                                        // stackView.push(second);
                                    }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "black"
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100

                        RowLayout {
                            anchors.fill: parent
                            spacing: 16

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "black"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        process.command.push(Config.controlcenter.commands.poweroff);
                                        process.running = true;
                                        // stackView.push(second);
                                    }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "black"
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color: "red"
                    }

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
                            text: SystemUsage.cpu.usage * 100 + "%"
                        }
                        Text {
                            text: SystemUsage.mem.usage * 100 + "%"
                        }
                    }
                }
            }
        }

        Process {
            id: process
            command: ["sh", "-c"]
        }
    }
}
