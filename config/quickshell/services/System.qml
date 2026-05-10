pragma Singleton

import QtQuick
import Quickshell

Singleton {
    enum Enum {
        Low,
        Normal = 0,
        Critical
    }

    readonly property SystemUsage usage: SystemUsage {}

    function poweroff() {
        Quickshell.execDetached(["systemctl", "poweroff"]);
    }

    function reboot() {
        Quickshell.execDetached(["systemctl", "reboot"]);
    }

    function logout() {
        Quickshell.execDetached(["uwsm", "stop"]);
    }

    function notify(title: string, body: string, icon: string, urgency: int): void {
        let _urgency;
        if (urgency === System.Low)
            _urgency = "low";
        if (urgency === System.Normal)
            _urgency = "normal";
        if (urgency === System.Critical)
            _urgency = "critical";

        let cmd = ["notify-send", "-a", "dotfiles", "-u", _urgency];

        // TODO find a better way to check if undefined
        if (icon != "null") {
            cmd.push("-i", icon);
        }

        cmd.push(title, body);
        Quickshell.execDetached(cmd);
    }
}
