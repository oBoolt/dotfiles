pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick

import qs.config

Singleton {
    id: root

    property bool _showOsd: false
    readonly property bool showOsd: Config.modules.osd && _showOsd
    property bool valueType: false
    property bool textType: false

    property int icon: 0
    property real value: 0
    property string text: ""

    function show(icon: int, value: real): void {
        if (!Config.modules.osd)
            return;

        root.valueType = true;
        root.textType = false;

        root._showOsd = true;
        root.icon = icon;
        root.value = value;
        timer.restart();
    }

    function showText(icon: int, text: string): void {
        if (!Config.modules.osd)
            return;

        root.valueType = false;
        root.textType = true;

        root._showOsd = true;
        root.icon = icon;
        root.text = text;
        timer.restart();
    }

    IpcHandler {
        target: "osd"

        function showText(icon: int, text: string): void {
            root.showText(icon, text);
        }
    }

    Timer {
        id: timer
        interval: Config.osd.timeout
        onTriggered: {
            root._showOsd = false;
        }
    }
}
