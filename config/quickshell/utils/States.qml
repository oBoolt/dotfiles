pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications

import QtQuick

import qs.config

Singleton {
    id: root
    property bool showControlCenter: false
    property bool showCalendar: false
    property bool showMpris: false
    property int currentClientIndex: 0
    property bool sessionLocked: false
    property int barZone: 30
    readonly property bool isPopupOpen: (Config.modules.calendar && showCalendar || Config.modules.mpris && showMpris || Config.modules.controlcenter && showControlCenter)

    property ShellScreen currentScreen
    property NotificationServer notificationServer

    function updateCurrentScreen(): void {
        Hyprland.refreshMonitors();
        let currentMonitor = Hyprland.focusedMonitor ?? Hyprland.monitors.values[0];
        for (let i = 0; i < Quickshell.screens.length; i++) {
            if (Quickshell.screens[i].name == currentMonitor.name) {
                root.currentScreen = Quickshell.screens[i];
            }
        }
    }

    function toggleControlCenter(): void {
        root.showControlCenter = !root.showControlCenter;
    }

    function toggleCalendar(): void {
        root.showCalendar = !root.showCalendar;
    }

    function toggleMpris(): void {
        root.showMpris = !root.showMpris;
    }

    function lockSession(): void {
        root.sessionLocked = true;
    }

    function unlockSession(): void {
        root.sessionLocked = false;
    }

    function closeAll(): void {
        root.showCalendar = false;
        root.showMpris = false;
        root.showControlCenter = false;
    }
}
