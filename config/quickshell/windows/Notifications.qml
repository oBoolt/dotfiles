pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.widgets.notifications

LazyLoader {
    id: root
    required property NotificationServer notificationServer
    readonly property int size: {
        if (root.notificationServer.trackedNotifications.values.length >= Config.notification.maxDisplay)
            return Config.notification.maxDisplay;
        return root.notificationServer.trackedNotifications.values.length;
    }

    active: Config.notification.enabled

    PanelWindow {
        screen: Quickshell.screens[0]

        visible: root.size > 0
        implicitWidth: Config.notification.width
        implicitHeight: Config.notification.height * root.size + root.size * (Appearance.spacing.small - 1)
        color: Config.debug ? Colors.orange : "transparent"

        anchors {
            right: true
            top: true
        }

        margins {
            top: Appearance.margin.normal
            right: Appearance.margin.normal
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: Appearance.spacing.small

            Repeater {
                model: root.notificationServer.trackedNotifications
                Notification {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Config.notification.height
                    Layout.alignment: Qt.AlignTop
                }
            }
        }
    }
}
