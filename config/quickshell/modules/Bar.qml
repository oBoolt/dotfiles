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
        implicitHeight: 35 * Config.scaleFactor

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
                    anchors.verticalCenter: parent.verticalCenter
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
                    Card {
                        icon: Utils.Icons.CPU
                        color: Colors.red
                    }
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
