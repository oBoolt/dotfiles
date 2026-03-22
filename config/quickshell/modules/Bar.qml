import Quickshell

import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.components.bar
import qs.utils as Utils

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: root
        required property ShellScreen modelData
        screen: modelData

        color: Colors.background
        implicitHeight: 30 * Config.scaleFactor[screen.name]

        anchors {
            top: true
            left: true
            right: true
        }

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
                color: Config.debug ? Colors.aqua : "transparent"
                Layout.fillWidth: true
                Layout.fillHeight: true

                // TODO: Make a nicer way to access mpris
                MouseArea {
                    anchors.fill: parent
                    onClicked: Utils.States.showMpris = !Utils.States.showMpris
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

                    Menu {}
                    Separator {}
                    Battery {}
                    Volume {}
                    Card {
                        icon: Utils.Icons.NetworkBluetoothSymbolic
                        color: Colors.darkblue
                    }
                    SystemUsage {}
                    Card {
                        icon: Utils.Icons.NetworkWiredActivatedSymbolic
                        color: Colors.darkgreen
                    }
                    Brightness {}
                }
            }
            Item {
                Layout.leftMargin: Appearance.padding.large - Appearance.spacing.normal
            }
        }
    }
}
