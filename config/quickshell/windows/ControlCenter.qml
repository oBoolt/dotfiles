import Quickshell
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.utils
import qs.widgets
import qs.services
import qs.settings

LazyLoader {
    active: Config.controlcenter.enabled && States.showControlCenter

    PanelWindow {
        // TODO: only open in the screen that was clicked
        anchors {
            top: true
            right: true
        }

        margins {
            top: 8
            right: 8
        }

        implicitWidth: 500
        implicitHeight: 600

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: mainPage
        }

        Component {
            id: mainPage
            Page {
                ColumnLayout {
                    anchors.margins: 16
                    anchors.fill: parent
                    spacing: 16

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
                                        stackView.push(second);
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
                                value: Pipewire.defaultAudioSink.audio.volume

                                onMoved: {
                                    Pipewire.defaultAudioSink.audio.volume = this.value;
                                }
                            }

                            Slider {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                value: Brightness.values.percentage

                                onMoved: {
                                    let current = Brightness.values.max * this.value;
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
                    color: "yellow"
                }
            }
        }
    }
}
