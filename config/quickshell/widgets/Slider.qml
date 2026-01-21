import QtQuick
import QtQuick.Controls

import qs.widgets

Slider {
    id: root
    from: 0
    to: 1
    handle: Item {}
    background: Rectangle {
        color: "yellow"
        Rectangle {
            color: "blue"
            implicitWidth: root.visualPosition * parent.width
            implicitHeight: parent.height
        }
    }

    Text {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 16
        color: "black"
        text: "I"
        verticalAlignment: Text.AlignVCenter
    }
}
