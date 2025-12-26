import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.settings
import qs.widgets.common

Rectangle {
    id: notification
    required property var modelData
    radius: Variables.notificationRadius
    color: Colors.background
    border {
        width: Variables.notificationBorder
        color: {
            if (notification.modelData.urgency == NotificationUrgency.Normal) {
                return Colors.yellow;
            }
            if (notification.modelData.urgency == NotificationUrgency.Critical) {
                return Colors.darkred;
            }
            if (notification.modelData.urgency == NotificationUrgency.Low) {
                return Colors.aqua;
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: event => notification.modelData.dismiss()

        RowLayout {
            anchors.centerIn: parent
            spacing: Variables.notificationSpacing

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                color: "transparent"

                IconImage {
                    anchors.centerIn: parent
                    source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/default-notification.svg")
                    implicitSize: parent.height - 16

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: Colors.foreground
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 2

                Text {
                    Layout.fillWidth: true
                    font.pixelSize: Variables.fontSize + 4
                    text: notification.modelData.summary
                }

                Rectangle {
                    Layout.preferredWidth: parent.width - 20
                    height: 1
                    color: Colors.foreground
                }

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    wrapMode: Text.Wrap
                    text: notification.modelData.body
                }
            }
        }
    }
}
