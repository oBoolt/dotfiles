pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    enum Enum {
        Low,
        Normal = 0,
        Critical,
        Text,
        Image
    }

    readonly property SystemUsage usage: SystemUsage {}
    property string user
    property string hostname

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

    function copyToClipboard(type: int, content: string): void {
        if (type == System.Image) {
            Quickshell.execDetached(["sh", "-c", "wl-copy --type image/jpg < " + content]);
            return;
        }

        if (type == System.Text) {
            Quickshell.execDetached(["wl-copy", content]);
            return;
        }
    }

    FileView {
        path: Qt.resolvedUrl("/etc/hostname")
        onLoaded: root.hostname = this.text().trim()
    }

    Process {
        running: true
        command: ["whoami"]
        stdout: StdioCollector {
            onStreamFinished: root.user = this.text.trim()
        }
    }
}
