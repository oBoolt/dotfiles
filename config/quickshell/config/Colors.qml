pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property alias darkMode: adapter.darkMode
    property alias background: adapter.background
    property alias foreground: adapter.foreground
    property alias main: adapter.main
    property alias critical: adapter.critical
    property alias danger: adapter.danger
    property alias warning: adapter.warning
    property alias ok: adapter.ok
    property alias good: adapter.good

    property color foregroundMuted: darkMode ? Qt.hsla(foreground.hslHue, foreground.hslSaturation * 0.1, foreground.hslLightness - 0.25, 1) : Qt.hsla(foreground.hslHue, foreground.hslSaturation * 0.1, foreground.hslLightness + 0.25, 1)
    property color backgroundMuted: darkMode ? Qt.hsla(background.hslHue, background.hslSaturation * 0.1, background.hslLightness + 0.15, 1) : Qt.hsla(background.hslHue, background.hslSaturation * 0.1, background.hslLightness - 0.15, 1)
    property color disabled: Qt.hsla(foreground.hslHue, foreground.hslSaturation * 0.1, foreground.hslLightness * 0.5)

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl(Quickshell.env("HOME") + "/.local/share/dotfiles/themes/current/quickshell.json")
        watchChanges: true

        onFileChanged: reload()
        onLoadFailed: error => {
            console.error("failed to load colors file");
            console.error("using default colors instead");
            console.error("reason: " + FileViewError.toString(error));
        }

        JsonAdapter {
            id: adapter
            property bool darkMode: true
            property color background: darkMode ? "black" : "white"
            property color foreground: darkMode ? "white" : "black"
            property color main: "aqua"
            property color critical: "darkred"
            property color danger: "red"
            property color warning: "yellow"
            property color ok: "green"
            property color good: "darkred"
        }
    }
}
