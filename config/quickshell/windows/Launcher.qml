import Quickshell

import QtQuick
import QtQuick.Layouts

import qs.settings

Variants {
    model: Quickshell.screens
    PanelWindow {
        required property ShellScreen modelData
        screen: modelData
        visible: false

        color: "transparent"

        implicitHeight: 200
        implicitWidth: 200

        Rectangle {
            anchors.fill: parent
            opacity: 0.05

            Repeater {
                model: DesktopEntries.applications
                delegate: Item {
                    required property var modelData
                }
            }
        }
    }
}
