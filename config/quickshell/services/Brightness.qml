pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

import qs.utils
import qs.config

Singleton {
    id: root
    property bool valid: false
    property int current: 1
    property int max: 1
    property real percentage: current / max
    property int icon

    onCurrentChanged: {
        icon = root.getBrightnessIcon(percentage);
    }

    function set(percentage: real): void {
        let v = Math.min(Math.max(root.max * 0.01, root.max * percentage), root.max);
        setProcess.command.push(v);
        setProcess.running = true;
        setProcess.command.pop();
    }

    function increase(): void {
        let value = root.percentage + Config.brightness.step;
        root.set(value);
    }

    function decrease(): void {
        let value = root.percentage - Config.brightness.step;
        root.set(value);
    }

    function getBrightnessIcon(percentage: real): int {
        return Icons.DisplayBrightnessSymbolic;
        // if (percentage >= 0.9) {
        //     return Icons.Brightness90Symbolic;
        // } else if (percentage >= 0.75) {
        //     return Icons.Brightness75Symbolic;
        // } else if (percentage >= 0.6) {
        //     return Icons.Brightness60Symbolic;
        // } else if (percentage >= 0.45) {
        //     return Icons.Brightness45Symbolic;
        // } else if (percentage >= 0.30) {
        //     return Icons.Brightness30Symbolic;
        // } else if (percentage >= 0.15) {
        //     return Icons.Brightness15Symbolic;
        // } else {
        //     return Icons.Brightness0Symbolic;
        // }
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

    Process {
        running: true
        command: ["sh", "-c", "command -v brightnessctl >/dev/null; echo $?"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (parseInt(this.text) == 0)
                    root.valid = true;
            }
        }
    }

    FileView {
        id: currentFile
        path: Qt.resolvedUrl(Config.paths.backlight + "/actual_brightness")
        watchChanges: true
        onLoadFailed: e => {
            root.valid = false;
        }
        onLoaded: {
            root.current = parseInt(text());
            root.icon = root.getBrightnessIcon(root.percentage);
        }
        onFileChanged: {
            this.reload();
            root.current = parseInt(text());
        }
    }

    FileView {
        blockLoading: true
        path: Qt.resolvedUrl(Config.paths.backlight + "/max_brightness")
        onLoadFailed: e => {
            root.valid = false;
        }
        onLoaded: {
            root.max = parseInt(text());
        }
    }

    Process {
        id: setProcess
        command: ["brightnessctl", "set"]
    }
}
