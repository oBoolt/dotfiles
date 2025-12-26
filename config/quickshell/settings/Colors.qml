pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property color background: "white"
    property color backgroundc: "white"
    property color foreground: "black"
    property color foregroundc: "black"
    property color red: "red"
    property color darkred: "darkred"
    property color green: "green"
    property color darkgreen: "darkgreen"
    property color yellow: "yellow"
    property color darkyellow: "gold"
    property color blue: "blue"
    property color darkblue: "darkblue"
    property color purple: "purple"
    property color darkpurple: "darkmagenta"
    property color aqua: "aqua"
    property color darkaqua: "darkcyan"
    property color orange: "orange"
    property color darkorange: "darkorange"
    property color gray: "gray"

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl(Quickshell.env("HOME") + "/theme.json")
        watchChanges: true
        onFileChanged: reload()
        blockLoading: true

        onLoadFailed: error => {
            console.error("failed to load colors file");
            console.error("using default colors instead");
            console.error("Reason: " + FileViewError.toString(error));
        }

        onLoaded: () => {
            console.info("loaded colors file: '" + jsonFile.path + "'");
            let colorsJson = JSON.parse(this.text());

            root.background = colorsJson.background;
            root.backgroundc = colorsJson.backgroundc;
            root.foreground = colorsJson.foreground;
            root.foregroundc = colorsJson.foregroundc;
            root.red = colorsJson.red;
            root.darkred = colorsJson.darkred;
            root.green = colorsJson.green;
            root.darkgreen = colorsJson.darkgreen;
            root.yellow = colorsJson.yellow;
            root.darkyellow = colorsJson.darkyellow;
            root.blue = colorsJson.blue;
            root.darkblue = colorsJson.darkblue;
            root.purple = colorsJson.purple;
            root.darkpurple = colorsJson.darkpurple;
            root.aqua = colorsJson.aqua;
            root.darkaqua = colorsJson.darkaqua;
            root.orange = colorsJson.orange;
            root.darkorange = colorsJson.darkorange;
            root.gray = colorsJson.gray;
        }
    }
}
