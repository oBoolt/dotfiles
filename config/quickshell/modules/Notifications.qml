import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

import qs.config
import qs.utils
import qs.components

Item {
    id: root

    NotificationServer {
        id: server
        bodySupported: true
        imageSupported: true

        onNotification: not => {
            not.tracked = true;
        }

        Component.onCompleted: ModulesState.setNotificationServer(server)
    }

    implicitWidth: 300
    implicitHeight: column.height
    anchors {
        top: parent.top
        right: parent.right

        topMargin: Appearance.margin.normal + States.barZone
        rightMargin: Appearance.margin.normal
    }

    ColumnLayout {
        id: column
        width: parent.width
        spacing: Appearance.spacing.normal

        Repeater {
            model: server.trackedNotifications
            delegate: Rectangle {
                id: not
                required property Notification modelData
                implicitWidth: parent.width
                implicitHeight: 60
                color: Colors.background
                border.width: 2
                border.color: modelData.urgency === NotificationUrgency.Critical ? Colors.danger : Colors.container

                Timer {
                    id: timer
                    running: not.modelData.urgency !== NotificationUrgency.Critical
                    interval: Config.notification.timeout
                    onTriggered: not.modelData.dismiss()
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        timer.running = false;
                        not.modelData.dismiss();
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: Appearance.spacing.small

                    Image {
                        Layout.preferredHeight: parent.height
                        Layout.preferredWidth: height
                        Layout.alignment: Qt.AlignTop
                        fillMode: Image.PreserveAspectFit
                        visible: source.toString() !== ""
                        source: not.modelData.image || not.modelData.appIcon || ""
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                        spacing: 0

                        Text {
                            Layout.fillWidth: true
                            text: not.modelData.summary
                            elide: Text.ElideRight
                        }
                        Text {
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                            text: not.modelData.body
                            font.bold: false
                            font.pixelSize: Appearance.font.small
                            visible: text !== ""
                        }
                    }
                }
            }
        }
    }
}
