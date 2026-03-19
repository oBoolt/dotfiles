import QtQuick
import Quickshell.Hyprland

import qs.config

Repeater {
    model: 5
    Rectangle {
        id: workspaceNode
        required property int index
        readonly property HyprlandWorkspace workspace: Hyprland.workspaces.values.find(ws => ws.id == index + 1) ?? null
        implicitWidth: 12
        implicitHeight: implicitWidth
        radius: width / 2
        color: workspace != null ? Colors.aqua : Colors.gray

        Rectangle {
            visible: !workspaceNode.workspace?.active
            anchors.margins: parent.width * 0.2
            anchors.fill: parent
            radius: width / 2
            color: Colors.background
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: _ => {
                Hyprland.dispatch("workspace " + (parent.index + 1));
            }
        }
    }
}
