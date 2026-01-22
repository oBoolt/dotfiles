import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.helpers
import qs.widgets
import qs.utils
import qs.widgets.bar

Variants {
    model: Quickshell.screens
    PanelWindow {
        id: root
        required property ShellScreen modelData
        screen: modelData

        color: Colors.background
        implicitHeight: Config.bar.size

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

                // TODO: create button to open control center
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        States.showControlCenter = !States.showControlCenter;
                    }
                }

                RowLayout {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    layoutDirection: Qt.RightToLeft
                    spacing: Appearance.spacing.normal

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
                    Brightness {}
                }
            }
            Item {
                Layout.leftMargin: Appearance.padding.large - Appearance.spacing.normal
            }
        }
    }
}
