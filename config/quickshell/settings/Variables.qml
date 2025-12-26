pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property bool debug: false

    readonly property int barSize: 35
    readonly property int barPadding: 16
    readonly property int barSpacing: 8
    readonly property int barRadius: 6

    readonly property string fontFamily: "JetBrainsMono Nerd Font Propo"
    readonly property int fontSize: 14

    readonly property real iconSize: 20

    readonly property int notificationWidth: 350
    readonly property int notificationHeight: 100
    readonly property int notificationsMaxDisplay: 5
    readonly property int notificationSpacing: 6
    readonly property int notificationBorder: 2
    readonly property int notificationRadius: 6

    readonly property int calendarPadding: 8
    readonly property int calendarRadius: 3

    readonly property int cardSpacing: 6
    readonly property int cardPadding: 6
    readonly property int cardRadius: 3

    readonly property int osdWidth: 200
    readonly property int osdHeight: 50
    readonly property int osdRadius: 6
    readonly property int osdTimer: 1000
}
