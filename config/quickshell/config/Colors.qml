pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    // property real hue: 0
    // property real saturation: 0.5
    property alias hue: adapter.main.hslHue
    property alias saturation: adapter.main.hslSaturation

    // property color background: Qt.hsla(hue, 0, 0, 1)
    property alias background: adapter.background
    property color containerMute: Qt.hsla(hue, background.hslSaturation / 2, background.hslLightness + 0.05, 1)
    property color container: Qt.hsla(hue, background.hslSaturation / 2, background.hslLightness + 0.2, 1)

    // property color foreground: Qt.hsla(hue, 0, 0.9, 1)
    property alias foreground: adapter.foreground
    property color foregroundMute: Qt.hsla(hue, foreground.hslSaturation * 0.1, foreground.hslLightness - 0.2, 1)

    property color main: Qt.hsla(hue, saturation, 0.6, 1)
    property color topMain: Qt.hsla(hue, main.hslSaturation, main.hslLightness - 0.4, 1)

    property color danger: Qt.hsla(0, saturation * 1.25, 0.5, 1)
    property color warning: Qt.hsla(60, saturation * 1.25, 0.5, 1)
    property color good: Qt.hsla(120, saturation * 1.25, 0.5, 1)

    function getColor(percentage: real): color {
        if (percentage >= 0.75)
            return root.good;
        if (percentage >= 0.35)
            return root.warning;
        if (percentage < 0.35)
            return root.danger;
    }

    function getColorInverse(percentage: real): color {
        if (percentage >= 0.75)
            return root.danger;
        if (percentage >= 0.35)
            return root.warning;
        if (percentage < 0.35)
            return root.good;
    }

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
        }
    }
}
