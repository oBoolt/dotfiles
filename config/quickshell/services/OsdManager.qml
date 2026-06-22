pragma Singleton

import Quickshell
import QtQuick

import qs.config

Singleton {
    id: root

    property bool _showOsd: false
    readonly property bool showOsd: Config.modules.osd && _showOsd

    property int icon: 0
    property real value: 0

    function show(icon: int, value: real): void {
        root._showOsd = true;
        root.icon = icon;
        root.value = value;
        timer.restart();
    }

    Timer {
        id: timer
        interval: Config.osd.timeout
        onTriggered: {
            root._showOsd = false;
        }
    }
}
