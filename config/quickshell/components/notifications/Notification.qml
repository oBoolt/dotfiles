import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.config
import qs.components

Rectangle {
    id: notification
    required property Notification modelData
    readonly property bool hasIcon: modelData.image !== "" || modelData.appIcon !== ""
    color: Colors.background
    border {
        width: Config.notification.borderSize
        color: {
            if (notification.modelData.urgency == NotificationUrgency.Normal) {
                return Colors.foreground;
            } else if (notification.modelData.urgency == NotificationUrgency.Critical) {
                return Colors.critical;
            } else if (notification.modelData.urgency == NotificationUrgency.Low) {
                return Colors.warning;
            }
        }
    }

    function getSource(): string {
        let image = this.modelData.image;
        let icon = this.modelData.appIcon;

        if (image !== "") {
            return Qt.resolvedUrl(image);
        }
        if (icon !== "")
            return Quickshell.iconPath(icon);

        return Qt.resolvedUrl(Quickshell.shellDir + "/assets/default-notification.svg");
    }

    Component.onCompleted: {
        if (notification.modelData.expireTimeout != -1) {
            timer.interval = notification.modelData.expireTimeout * 1000;
        } else {
            timer.interval = 3000;
        }

        timer.start();
    }

    Timer {
        id: timer
        onTriggered: notification.modelData.expire()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: event => notification.modelData.dismiss()
    }

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
                source: notification.getSource()
                implicitSize: parent.height / 9 * 8

                ColorOverlay {
                    visible: !notification.hasIcon
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
                textFormat: Text.PlainText
                text: notification.modelData.body
            }
        }
    }
}
