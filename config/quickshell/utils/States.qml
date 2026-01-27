pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property bool showControlCenter: false
    property bool showCalendar: false

    property ShellScreen currentScreen

    function updateCurrentScreen(): void {
        modelProcess.running = true;
    }

    Process {
        id: modelProcess
        command: ["sh", "-c", "hyprctl -j monitors | jq -rjM '.[] | select(.focused == true) | .name'"]
        stdout: StdioCollector {
            onStreamFinished: {
                var out;
                for (let i = 0; i < Quickshell.screens.length; i++) {
                    let current = Quickshell.screens[i];
                    if (current.name == this.text) {
                        out = current;
                    }
                }

                root.currentScreen = out;
            }
        }
    }
}
