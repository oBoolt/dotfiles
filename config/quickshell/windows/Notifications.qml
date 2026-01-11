pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.widgets.notifications

Item {
    id: root
    required property NotificationServer notificationServer
    readonly property int size: {
        if (root.notificationServer.trackedNotifications.values.length >= Variables.notificationsMaxDisplay)
            return Variables.notificationsMaxDisplay;
        return root.notificationServer.trackedNotifications.values.length;
    }

    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property ShellScreen modelData
            screen: modelData

            visible: root.size > 0
            implicitWidth: Variables.notificationWidth
            implicitHeight: Variables.notificationHeight * root.size + root.size * (Variables.notificationSpacing - 1)
            color: Variables.debug ? Colors.orange : "transparent"

            anchors {
                right: true
                top: true
            }

            margins {
                top: Variables.notificationMargin
                right: Variables.notificationMargin
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: Variables.notificationSpacing

                Repeater {
                    model: root.notificationServer.trackedNotifications
                    Notification {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Variables.notificationHeight
                        Layout.alignment: Qt.AlignTop
                    }
                }
            }
        }
    }
}
