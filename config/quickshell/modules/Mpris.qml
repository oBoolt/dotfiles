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
        color: Colors.background

        property MprisPlayer current: Mpris.players.values[States.currentClientIndex]
        readonly property bool multipleClients: Mpris.players.values.length > 1
        readonly property bool haveClient: !!Mpris.players.values.length

        function displaySeconds(seconds: int): string {
            let hours = seconds >= (60 * 60);
            return hours ? (parseInt(seconds / (60 * 60)) + ":" + (parseInt(seconds / 60) % 60) + ":" + ((seconds % 60) < 10 ? "0" + (seconds % 60) : (seconds % 60))) : (parseInt(seconds / 60) + ":" + ((seconds % 60) < 10 ? "0" + (seconds % 60) : (seconds % 60)));
        }

        function nextClient(): void {
            States.currentClientIndex = (States.currentClientIndex + 1) % Mpris.players.values.length;
        }

        function previousClient(): void {
            States.currentClientIndex = (States.currentClientIndex - 1) < 0 ? (Mpris.players.values.length - 1) : (States.currentClientIndex - 1);
        }

        Timer {
            running: root.haveClient && root.current.playbackState == MprisPlaybackState.Playing
            interval: 500
            repeat: true
            onTriggered: root.current.positionChanged()
        }

        Item {
            anchors.margins: 8
            anchors.fill: parent

            Text {
                anchors.fill: parent
                visible: !root.haveClient
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Appearance.font.large
                text: "No player available"
            }

            RowLayout {
                visible: root.haveClient
                anchors.fill: parent

                Image {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    source: root.current.metadata["mpris:artUrl"] ?? Qt.resolvedUrl(Quickshell.shellRoot + "/assets/default-album.jpg")
                }

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Text {
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                        text: root.current.trackTitle || "Unknown Title"
                    // Album Image
                    Image {
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        source: root.current.trackArtUrl || Qt.resolvedUrl(Quickshell.shellDir + "/assets/default-album.jpg")
                    }
                    Text {
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                        text: root.current.trackArtist || "Unknown Artist"
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.maximumHeight: 16
                        Layout.alignment: Qt.AlignHCenter

                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            icon: Icons.MediaSkipBackwardSymbolic
                            enabled: root.current.canGoPrevious
                            onClicked: root.current.previous()
                        }
                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            icon: root.current.playbackState == MprisPlaybackState.Playing ? Icons.MediaPlaybackPauseSymbolic : Icons.MediaPlaybackStartSymbolic
                            enabled: root.current.canTogglePlaying
                            onClicked: root.current.togglePlaying()
                        }
                        ButtonIcon {
                            Layout.preferredWidth: Appearance.font.icon
                            Layout.preferredHeight: Appearance.font.icon
                            icon: Icons.MediaSkipForwardSymbolic
                            enabled: root.current.canGoNext
                            onClicked: root.current.canGoNext
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Rectangle {
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                            height: 4

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onPositionChanged: e => {
                                    currentIndicator.width = (e.x / this.width) * parent.width;
                                // console.log(JSON.stringify(e, null, 2));
                                }
                                onReleased: e => {
                                    root.current.position = (e.x / this.width) * root.current.length;
                                    currentIndicator.implicitWidth = (root.current.position / root.current.length) * parent.width;
                                }
                            }

                            Rectangle {
                                id: currentIndicator

                                anchors {
                                    left: parent.left
                                    top: parent.top
                                    bottom: parent.bottom
                                }

                                implicitWidth: (1 % (root.current.position / root.current.length)) * parent.width

                                color: "red"
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true

                        Text {
                            text: root.displaySeconds(root.current.position)
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: root.displaySeconds(root.current.length)
                        }
                    }
                }
            }
        }
    }
}
