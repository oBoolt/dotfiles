pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

import qs.services

Singleton {
    id: root
    property rect _area
    property string _path

    function capture(area: rect): void {
        let region = area.x + "," + area.y + " " + area.width + "x" + area.height;
        let path = Quickshell.env("HOME") + "/Pictures/dotfiles-" + Time.path + ".jpg";

        root._area = area;
        root._path = path;

        process.command.push(region);
        process.command.push(path);
        process.running = true;
    }

    Process {
        id: process
        running: false
        command: ["grim", "-g"]
        stdout: StdioCollector {
            onStreamFinished: {
                process.running = false;
                process.command.pop();
                process.command.pop();
            }
        }

        onExited: code => {
            if (code === 0) {
                System.notify("Screenshot taken", "At: " + root._area.x + "," + root._area.y + " " + root._area.width + "x" + root._area.height, root._path);
                System.copyToClipboard(System.Image, root._path);
            }

            if (code === 1)
                console.log("Failed to take screenshot");
        }
    }
}
