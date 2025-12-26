import QtQuick
import Quickshell.Hyprland

import qs.settings
import qs.widgets.common

Repeater {
    model: 5
    Text {
        id: workspaceNode
        required property int index
        readonly property HyprlandWorkspace workspace: Hyprland.workspaces.values.find(ws => ws.id == index + 1) ?? null
        text: workspace?.active ? "" : ""
        font.pixelSize: Variables.iconSize
        color: workspace != null ? Colors.aqua : Colors.gray

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: _ => {
                Hyprland.dispatch("workspace " + (parent.index + 1));
            }
        }
    }
}
