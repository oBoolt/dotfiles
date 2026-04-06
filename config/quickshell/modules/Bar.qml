import Quickshell

import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.components.bar
import qs.utils as Utils

LazyLoader {
    active: Config.modules.bar && (Quickshell.screens.length > 0)

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property ShellScreen modelData
            screen: modelData

            color: "transparent"
            implicitHeight: (30 * Config.scaleFactor[screen.name]) + (Config.bar.floating ? Appearance.margin.normal : 0)

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors {
                    topMargin: Config.bar.floating && Appearance.margin.normal
                    leftMargin: Config.bar.floating && Appearance.margin.normal
                    rightMargin: Config.bar.floating && Appearance.margin.normal
                }
                anchors.fill: parent
                color: Colors.background
                radius: Appearance.radius.small

                RowLayout {
                    anchors.fill: parent
                    spacing: Appearance.spacing.normal

                    Item {
                        Layout.leftMargin: Appearance.padding.large - Appearance.spacing.normal
                    }
                    Rectangle {
                        id: left_area
                        color: Config.debug ? Colors.orange : "transparent"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        RowLayout {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            spacing: Appearance.spacing.normal

                            Clock {
                                parentWindow: root
                            }
                            Separator {}
                            Workspaces {}
                            Separator {}
                            WindowState {}
                        }
                    }
                    Rectangle {
                        id: center_area
                        color: Config.debug ? Colors.main : "transparent"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        // TODO: Make a nicer way to access mpris
                        MouseArea {
                            anchors.fill: parent
                            onClicked: Utils.States.toggleMpris()
                        }

                        Title {
                            anchors.centerIn: parent
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Rectangle {
                        id: right_area
                        color: Config.debug ? Colors.purple : "transparent"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        RowLayout {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            layoutDirection: Qt.RightToLeft
                            spacing: Appearance.spacing.normal

                            Menu {
                                Layout.preferredHeight: Appearance.font.icon
                            }
                            Separator {}
                            Battery {
                                Layout.preferredHeight: Appearance.font.icon
                            }
                            Volume {
                                Layout.preferredHeight: Appearance.font.icon
                            }
                            //TODO: Bluetooth
                            //TODO: Network
                            //TODO: SystemUsage
                        }
                    }
                    Item {
                        Layout.leftMargin: Appearance.padding.large - Appearance.spacing.normal
                    }
                }
            }
        }
    }
}
