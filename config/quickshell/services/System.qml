pragma Singleton

import QtQuick
import Quickshell

Singleton {
    property SystemUsage usage: SystemUsage {}

    function poweroff() {
        Quickshell.execDetached(["systemctl", "poweroff"]);
    }

    function reboot() {
        Quickshell.execDetached(["systemctl", "reboot"]);
    }

    function logout() {
        Quickshell.execDetached(["hyprctl", "dispatch", "exit"]);
    }
}
