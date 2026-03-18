pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string seconds: Qt.formatDateTime(clock.date, "ss")
    readonly property string minutes: Qt.formatDateTime(clock.date, "mm")
    readonly property string hours: Qt.formatDateTime(clock.date, "hh")
    readonly property date date: clock.date

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
