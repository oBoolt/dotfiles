pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

import qs.utils

Singleton {
    function capture(x: int, y: int, width: int, height: int): void {
        let region = x + "," + y + " " + width + "x" + height;
        process.command.push(region);
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
            }
        }

        onExited: code => {
            if (code === 0)
                console.log("Screenshot saved in " + Quickshell.env("HOME") + "/Pictures");

            if (code === 1)
                console.log("Failed to take screenshot");
        }
    }
}
