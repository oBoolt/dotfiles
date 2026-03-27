import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets

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
            top: Appearance.margin.normal
        }

        implicitWidth: 450 * Config.scaleFactor[screen.name]
        implicitHeight: 130 * Config.scaleFactor[screen.name]
        color: "transparent"

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
            running: root.haveClient && root.current?.playbackState == MprisPlaybackState.Playing
            interval: 1000
            repeat: true
            onTriggered: root.current?.positionChanged()
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.radius.small
            color: Colors.background

            Item {
                anchors.margins: Appearance.margin.large
                anchors.fill: parent

                Text {
                    anchors.fill: parent
                    visible: !root.haveClient
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Appearance.font.large
                    text: "No player available"
                }

                Item {
                    visible: root.haveClient
                    anchors.fill: parent

                    RowLayout {
                        anchors.fill: parent
                        spacing: Appearance.spacing.normal

                        // Album Image
                        ClippingRectangle {
                            Layout.fillHeight: true
                            Layout.preferredWidth: height
                            radius: Appearance.radius.normal

                            Image {
                                id: album
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectCrop
                                mipmap: true
                                source: root.current?.trackArtUrl || Qt.resolvedUrl(Quickshell.shellDir + "/assets/default-album.jpg")
                            }
                        }

                        ColumnLayout {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            spacing: Appearance.spacing.normal

                            RowLayout {
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 0
                                    // Title
                                    Text {
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                        font.pixelSize: Appearance.font.large
                                        text: root.current?.trackTitle || "Unknown Title"
                                    }
                                    // Artist
                                    Text {
                                        Layout.fillWidth: true
                                        elide: Text.ElideRight
                                        color: Colors.foregroundMuted
                                        text: root.current?.trackArtist || "Unknown Artist"
                                    }
                                }

                                RowLayout {
                                    visible: root.multipleClients
                                    spacing: Appearance.spacing.small
                                    Layout.alignment: Qt.AlignTop

                                    ButtonIcon {
                                        Layout.preferredWidth: Appearance.font.icon
                                        Layout.preferredHeight: Appearance.font.icon
                                        hoverEnabled: true
                                        icon: Icons.GoPreviousSymbolic
                                        onClicked: root.previousClient()
                                    }
                                    ButtonIcon {
                                        Layout.preferredWidth: Appearance.font.icon
                                        Layout.preferredHeight: Appearance.font.icon
                                        hoverEnabled: true
                                        icon: Icons.GoNextSymbolic
                                        onClicked: root.nextClient()
                                    }
                                }
                            }

                            // Buttons Control
                            RowLayout {
                                Layout.fillWidth: true
                                Layout.maximumHeight: 16
                                Layout.alignment: Qt.AlignHCenter
                                spacing: Appearance.spacing.normal

                                ButtonIcon {
                                    Layout.preferredWidth: Appearance.font.icon
                                    Layout.preferredHeight: Appearance.font.icon
                                    icon: Icons.MediaSkipBackwardSymbolic
                                    enabled: root.current?.canGoPrevious ?? false
                                    hoverEnabled: true
                                    onClicked: root.current?.previous()
                                }
                                ButtonIcon {
                                    Layout.preferredWidth: Appearance.font.icon
                                    Layout.preferredHeight: Appearance.font.icon
                                    icon: root.current?.playbackState == MprisPlaybackState.Playing ? Icons.MediaPlaybackPauseSymbolic : Icons.MediaPlaybackStartSymbolic
                                    enabled: root.current?.canTogglePlaying ?? false
                                    hoverEnabled: true
                                    onClicked: root.current?.togglePlaying()
                                }
                                ButtonIcon {
                                    Layout.preferredWidth: Appearance.font.icon
                                    Layout.preferredHeight: Appearance.font.icon
                                    icon: Icons.MediaSkipForwardSymbolic
                                    enabled: root.current?.canGoNext ?? false
                                    hoverEnabled: true
                                    onClicked: root.current?.next()
                                }
                            }

                            // Progress bar
                            Item {
                                Layout.fillWidth: true

                                // Progress Bar background
                                Rectangle {
                                    anchors {
                                        left: parent.left
                                        right: parent.right
                                    }
                                    radius: Appearance.radius.small
                                    height: 4

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onPositionChanged: e => {
                                            currentIndicator.width = (e.x / this.width) * parent.width;
                                        }
                                        onReleased: e => {
                                            root.current.position = (e.x / this.width) * root.current?.length;
                                            currentIndicator.implicitWidth = (root.current?.position / root.current?.length) * parent.width;
                                        }
                                    }

                                    // Progress Bar indicator
                                    Rectangle {
                                        id: currentIndicator
                                        anchors {
                                            left: parent.left
                                            top: parent.top
                                            bottom: parent.bottom
                                        }
                                        color: Colors.main
                                        radius: Appearance.radius.small
                                        implicitWidth: ((root.current?.position / root.current?.length) % 1) * parent.width
                                    }
                                }
                            }

                            // Time
                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    text: root.displaySeconds(root.current?.position)
                                }

                                Item {
                                    Layout.fillWidth: true
                                }

                                Text {
                                    Layout.alignment: Qt.AlignRight
                                    text: root.displaySeconds(root.current?.length)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
