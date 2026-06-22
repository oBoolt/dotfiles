pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.Notifications

import QtQuick

Singleton {
    id: root

    property int currentClientIndex: 0
    property int barZone: 30

    property int areaPickerMode: 0
    property int systemTrayX: 0

    property ShellScreen currentScreen
    readonly property bool currentTopLevelFullscreen: ToplevelManager.activeToplevel?.fullscreen ?? false

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
