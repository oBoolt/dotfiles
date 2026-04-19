pragma ComponentBehavior: Bound
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

import qs.config
import qs.utils
import qs.components.notifications

Item {
    id: root
    // readonly property int properHeight: 100 * Config.getScaleFactor(screen)
    readonly property int properHeight: 75
    readonly property int size: {
        if (States.notificationServer?.trackedNotifications.values.length >= Config.notification.maxDisplay)
            return Config.notification.maxDisplay;
        return States.notificationServer?.trackedNotifications.values.length;
    }

    visible: root.size > 0
    // implicitWidth: 380 * Config.getScaleFactor(screen)
    implicitWidth: 300
    implicitHeight: properHeight * root.size + root.size * (Appearance.spacing.small - 1)
    // clip: true

    anchors {
        top: parent.top
        right: parent.right

        topMargin: Appearance.margin.normal + States.barZone
        rightMargin: Appearance.margin.normal
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Appearance.spacing.small

        Repeater {
            model: States.notificationServer?.trackedNotifications
            Notification {
                Layout.fillWidth: true
                Layout.preferredHeight: root.properHeight
                Layout.alignment: Qt.AlignTop
            }
        }
    }
}
