pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray

import qs.config
import qs.utils
import qs.components

Item {
    id: root

    readonly property int iconSize: Appearance.font.icon + 6
    readonly property int columns: 4
    readonly property int spacing: Appearance.spacing.small

    anchors.top: parent.top
    anchors.topMargin: Appearance.margin.normal + States.barZone
    x: States.systemTrayX

    implicitHeight: (iconSize + spacing * 2) * Math.ceil(SystemTray.items.values.length / columns)
    implicitWidth: parent.width * 0.1

    Loader {
        active: Config.modules.systemtray && States.showSystemTray
        anchors.fill: parent
        sourceComponent: Rectangle {
            anchors.fill: parent
            radius: Appearance.radius.small
            color: Colors.background

            GridLayout {
                anchors.fill: parent
                rowSpacing: root.spacing
                columnSpacing: 0
                columns: root.columns
                // rows: 3

                Repeater {
                    model: SystemTray.items
                    Item {
                        id: trayItem
                        required property SystemTrayItem modelData
                        property bool _hoverd: false

                        Layout.preferredHeight: root.iconSize
                        Layout.fillWidth: true

                        Rectangle {
                            id: background
                            anchors.centerIn: parent
                            implicitHeight: parent.height
                            implicitWidth: height
                            radius: Appearance.radius.small
                            color: trayItem._hoverd ? Colors.foreground : Colors.foregroundMute
                            opacity: 0.25
                        }

                        Icon {
                            anchors.fill: parent
                            iconString: parent.modelData.icon
                            rawSource: true
                            disableColor: true
                        }

                        MouseArea {
                            anchors.fill: background
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: trayItem._hoverd = true
                            onExited: trayItem._hoverd = false
                            onClicked: event => {
                                if (trayItem.modelData.onlyMenu)
                                    return;

                                if (event.button == Qt.LeftButton) {
                                    trayItem.modelData.activate();
                                }

                                if (event.button == Qt.RightButton) {
                                    trayItem.modelData.secondaryActivate();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
