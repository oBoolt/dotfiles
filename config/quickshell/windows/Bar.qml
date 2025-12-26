import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.helpers
import qs.widgets.common
import qs.widgets.bar

Variants {
    model: Quickshell.screens
    PanelWindow {
        id: root
        required property ShellScreen modelData
        screen: modelData

        color: Colors.background
        implicitHeight: Variables.barSize

        anchors {
            top: true
            left: true
            right: true
        }

        RowLayout {
            anchors.fill: parent
            spacing: Variables.barSpacing

            Item {
                Layout.leftMargin: Variables.barPadding - Variables.barSpacing
            }
            Rectangle {
                id: left_area
                color: Variables.debug ? Colors.orange : "transparent"
                Layout.fillWidth: true
                Layout.fillHeight: true

                RowLayout {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Variables.barSpacing

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
                color: Variables.debug ? Colors.aqua : "transparent"
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
                color: Variables.debug ? Colors.purple : "transparent"
                Layout.fillWidth: true
                Layout.fillHeight: true

                RowLayout {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    layoutDirection: Qt.RightToLeft
                    spacing: Variables.barSpacing

                    Battery {}
                    Volume {
                        node: Pipewire.defaultAudioSink
                    }
                    Card {
                        icon: Icons.NetworkBluetoothSymbolic
                        color: Colors.darkblue
                    }
                    Card {
                        icon: Icons.CPU
                        color: Colors.red
                    }
                    Card {
                        icon: Icons.NetworkWiredActivatedSymbolic
                        color: Colors.darkgreen
                    }
                    Card {
                        icon: Icons.Brightness90Symbolic
                        color: Colors.orange
                    }
                }
            }
            Item {
                Layout.rightMargin: Variables.barPadding - Variables.barSpacing
            }
        }
    }
}
