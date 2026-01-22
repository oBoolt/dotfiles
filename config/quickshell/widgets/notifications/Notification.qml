import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.settings
import qs.widgets

Rectangle {
    id: notification
    required property Notification modelData
    color: Colors.background
    border {
        width: Config.notification.borderSize
        color: {
            if (notification.modelData.urgency == NotificationUrgency.Normal) {
                return Colors.foreground;
            } else if (notification.modelData.urgency == NotificationUrgency.Critical) {
                return Colors.darkred;
            } else if (notification.modelData.urgency == NotificationUrgency.Low) {
                return Colors.blue;
            }
        }
    }

    function getIcon(): string {
        if (this.modelData.appIcon !== "")
            return Quickshell.iconPath(this.modelData.appIcon);
        else {
            return Qt.resolvedUrl(Quickshell.shellDir + "/assets/default-notification.svg");
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: event => notification.modelData.dismiss()

        RowLayout {
            anchors.margins: Appearance.margin.normal
            anchors.fill: parent
            spacing: Appearance.spacing.small

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                color: "transparent"

                IconImage {
                    anchors.centerIn: parent
                    source: notification.getIcon()
                    implicitSize: parent.height / 9 * 8

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
                    font {
                        pixelSize: Appearance.font.large
                    }
                    text: notification.modelData.summary
                }

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.bold: false
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    text: notification.modelData.body
                }
            }
        }
    }
}
