import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Mpris

import qs.config
import qs.utils
import qs.components

LazyLoader {
    active: Config.modules.mpris && States.showMpris

    PanelWindow {
        id: root
        screen: States.currentScreen
        exclusiveZone: 0

        anchors {
            top: true
        }

        margins {
            top: 8
        }

        implicitWidth: 450
        implicitHeight: 150
        color: "#353535"

        property MprisPlayer current: Mpris.players.values[0]

        function convertSecToMin(seconds: int): string {
            return (parseInt(seconds / 60) + ":" + ((seconds % 60) < 10 ? "0" + (seconds % 60) : (seconds % 60)));
        }

        Timer {
            running: root.current.playbackState == MprisPlaybackState.Playing
            interval: 1000
            repeat: true
            onTriggered: root.current.positionChanged()
        }

        Item {
            anchors.margins: 8
            anchors.fill: parent

            RowLayout {
                anchors.fill: parent

                Image {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    source: root.current.metadata["mpris:artUrl"]
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Text {
                        text: root.current.trackTitle || "Unknown Title"
                    }
                    Text {
                        text: root.current.trackArtist || "Unknown Artist"
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.maximumHeight: 16
                        Layout.alignment: Qt.AlignHCenter

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.preferredWidth: height

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.current.previous()
                            }
                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.preferredWidth: height

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.current.togglePlaying()
                            }
                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.preferredWidth: height

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.current.next()
                            }
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                        Rectangle {
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                            height: 2

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: e => {
                                    console.log(JSON.stringify(e, null, 2));
                                }
                            }

                            Rectangle {
                                anchors {
                                    left: parent.left
                                    top: parent.top
                                    bottom: parent.bottom
                                }

                                implicitWidth: (root.current.position / root.current.length) * parent.width

                                color: "red"
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true

                        Text {
                            text: root.convertSecToMin(root.current.position)
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: root.convertSecToMin(root.current.length)
                        }
                    }
                }
            }
        }
    }
}
