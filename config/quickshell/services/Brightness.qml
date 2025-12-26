pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

import qs.types
import qs.helpers
import qs.settings

Singleton {
    id: root
    property BrightnessType values: BrightnessType {}
    property int icon

    signal brightnessChanged

    function set(value: int): void {
        let v = Math.min(Math.max(root.values.max * 0.01, value), root.values.max);
        setProcess.command.push(v);
        setProcess.running = true;
        setProcess.command.pop();

        root.values.current = v;
        root.brightnessChanged();
        root.updateIcon();
    }

    function increase(): void {
        let value = root.values.current + (root.values.max * root.values.step);
        root.set(value);
    }

    function decrease(): void {
        let value = root.values.current - (root.values.max * root.values.step);
        root.set(value);
    }

    function updateIcon(): void {
        let p = root.values.percentage;
        if (p >= 0.9) {
            root.icon = Icons.Brightness90Symbolic;
            return;
        } else if (p >= 0.75) {
            root.icon = Icons.Brightness75Symbolic;
            return;
        } else if (p >= 0.6) {
            root.icon = Icons.Brightness60Symbolic;
            return;
        } else if (p >= 0.45) {
            root.icon = Icons.Brightness45Symbolic;
            return;
        } else if (p >= 0.30) {
            root.icon = Icons.Brightness30Symbolic;
            return;
        } else if (p >= 0.15) {
            root.icon = Icons.Brightness15Symbolic;
            return;
        } else {
            root.icon = Icons.Brightness0Symbolic;
            return;
        }
    }

    IpcHandler {
        target: "brightness"
        function set(value: int): void {
            root.set(value);
        }
        function increase(): void {
            root.increase();
        }
        function decrease(): void {
            root.decrease();
        }
    }

    Timer {
        id: timer
        interval: 2000
        running: true
        repeat: true
        onTriggered: currentProcess.running = true
    }

    Process {
        id: currentProcess
        command: ["/bin/cat", Variables.backlightPath + "/actual_brightness"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.values.current = parseInt(this.text);
            }
        }
    }

    Process {
        id: maxProcess
        command: ["/bin/cat", Variables.backlightPath + "/max_brightness"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.values.max = parseInt(this.text);
            }
        }
    }

    Process {
        id: setProcess
        command: ["brightnessctl", "set"]
    }
}
