pragma Singleton

import Quickshell
import Quickshell.Hyprland

import QtQuick

Singleton {
    id: root
    property bool showControlCenter: false
    property bool showCalendar: false
    property bool showMpris: false
    property int currentClientIndex: 0
    property bool sessionLocked: false

    property ShellScreen currentScreen

    function updateCurrentScreen(): void {
        Hyprland.refreshMonitors();
        let currentMonitor = Hyprland.focusedMonitor ?? Hyprland.monitors.values[0];
        for (let i = 0; i < Quickshell.screens.length; i++) {
            if (Quickshell.screens[i].name == currentMonitor.name) {
                root.currentScreen = Quickshell.screens[i];
            }
        }
    }
}
