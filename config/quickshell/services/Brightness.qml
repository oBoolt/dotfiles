pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

import qs.helpers
import qs.settings

Singleton {
    id: root
    property int current: 1
    property int max: 1
    property real percentage: current / max
    property int icon

    onCurrentChanged: {
        icon = Icons.getBrightnessIcon(percentage);
    }

    function set(value: int): void {
        let v = Math.min(Math.max(root.max * 0.01, value), root.max);
        setProcess.command.push(v);
        setProcess.running = true;
        setProcess.command.pop();
    }

    function increase(): void {
        let value = root.current + (root.max * Config.brightness.step);
        root.set(value);
    }

    function decrease(): void {
        let value = root.current - (root.max * Config.brightness.step);
        root.set(value);
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

    FileView {
        id: currentFile
        path: Qt.resolvedUrl(Config.paths.backlight + "/actual_brightness")
        watchChanges: true
        onLoaded: {
            root.current = parseInt(text());
        }
        onFileChanged: {
            this.reload();
            root.current = parseInt(text());
        }
    }

    FileView {
        blockLoading: true
        path: Qt.resolvedUrl(Config.paths.backlight + "/max_brightness")
        onLoaded: {
            root.max = parseInt(text());
        }
    }

    Process {
        id: setProcess
        command: ["brightnessctl", "set"]
    }

    Component.onCompleted: {
        root.icon = Icons.getBrightnessIcon(root.percentage);
    }
}
