pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property bool darkMode: true
    property color background: darkMode ? "black" : "white"
    property color backgroundMuted: darkMode ? Qt.hsla(background.hslHue, background.hslSaturation * 0.1, background.hslLightness + 0.15, 1) : Qt.hsla(background.hslHue, background.hslSaturation * 0.1, background.hslLightness - 0.15, 1)
    property color foreground: darkMode ? "white" : "black"
    property color foregroundMuted: darkMode ? Qt.hsla(foreground.hslHue, foreground.hslSaturation * 0.1, foreground.hslLightness - 0.25, 1) : Qt.hsla(foreground.hslHue, foreground.hslSaturation * 0.1, foreground.hslLightness + 0.25, 1)
    property color disabled: Qt.hsla(foreground.hslHue, foreground.hslSaturation * 0.1, foreground.hslLightness * 0.5)
    property color main: "aqua"
    property color critical: "darkred"
    property color danger: "red"
    property color warning: "yellow"
    property color ok: "green"
    property color good: "darkred"

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
        onLoaded: () => {
            let colorsJson = JSON.parse(this.text());

            root.darkMode = colorsJson.darkMode;
            root.background = colorsJson.background;
            root.foreground = colorsJson.foreground;
            root.main = colorsJson.main;
            root.critical = colorsJson.critical;
            root.danger = colorsJson.danger;
            root.warning = colorsJson.warning;
            root.ok = colorsJson.ok;
            root.good = colorsJson.good;
        }
    }
}
