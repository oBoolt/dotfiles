import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services

Page {
    Rectangle {
        anchors.fill: parent
        color: "black"

        ColumnLayout {
            Text {
                text: "CPU: " + System.usage.cpu.percentage * 100
            }
            Text {
                text: "MEM: " + System.usage.mem.percentage * 100
            }
        }
    }
}
