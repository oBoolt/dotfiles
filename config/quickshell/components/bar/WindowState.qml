import Quickshell.Wayland
import Quickshell.Hyprland

import QtQuick.Layouts

import qs.components
import qs.config

RowLayout {
    id: root
    readonly property bool hasSpecial: Hyprland.workspaces.values.filter(ws => ws.name === "special:magic").length != 0
    spacing: 0
    Text {
        text: ToplevelManager.activeToplevel?.maximized ? "Zoom" : "Normal"
    }
    Text {
        visible: root.hasSpecial
        text: "+"
        color: Colors.second
    }
}
