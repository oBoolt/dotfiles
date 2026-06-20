pragma Singleton

import Quickshell
import qs.config

Singleton {
    id: root

    property bool _showControlCenter: false
    property bool _showCalendar: false
    property bool _showMpris: false
    property bool _showAreaPicker: false
    property bool _showSystemTray: false
    property bool _showSessionLock: false

    readonly property bool showControlCenter: Config.modules.controlcenter && _showControlCenter
    readonly property bool showCalendar: Config.modules.calendar && _showCalendar
    readonly property bool showMpris: Config.modules.mpris && _showMpris
    readonly property bool showAreaPicker: Config.modules.areapicker && _showAreaPicker
    readonly property bool showSystemTray: Config.modules.systemtray && _showSystemTray
    readonly property bool showSessionLock: Config.modules.sessionlock && _showSessionLock

    readonly property bool isModuleOpen: showControlCenter || showCalendar || showMpris || showAreaPicker || showSystemTray

    function closeAll(): void {
        root._showControlCenter = false;
        root._showCalendar = false;
        root._showMpris = false;
        root._showAreaPicker = false;
        root._showSystemTray = false;
    }

    function toggleControlCenter(): void {
        root._showControlCenter = !root._showControlCenter;
    }

    function toggleCalendar(): void {
        root._showCalendar = !root._showCalendar;
    }

    function toggleMpris(): void {
        root._showMpris = !root._showMpris;
    }

    function toggleAreaPicker(): void {
        root._showAreaPicker = !root._showAreaPicker;
    }

    function toggleSystemTray(): void {
        root._showSystemTray = !root._showSystemTray;
    }

    function lockSession(): void {
        root._showSessionLock = true;
    }

    function unlockSession(): void {
        root._showSessionLock = false;
    }
}
