import Quickshell

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.utils
import qs.components
import qs.services
import qs.settings

LazyLoader {
    active: Config.modules.controlcenter && States.showControlCenter

    PanelWindow {
        // TODO: only open in the screen that was clicked
        screen: States.currentScreen
        anchors {
            top: true
            right: true
        }

        margins {
            top: 8
            right: 8
        }

        implicitWidth: 480 * Config.scaleFactor
        implicitHeight: 540 * Config.scaleFactor

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
                    color: "yellow"
                }
            }
        }
    }
}
