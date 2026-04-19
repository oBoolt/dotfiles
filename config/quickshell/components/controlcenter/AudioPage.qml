import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Pipewire

import qs.services
import qs.components

Page {
    id: root
    Rectangle {
        anchors.fill: parent
        color: "black"

        ColumnLayout {

            Text {
                text: Audio.sink.name
            }
            Text {
                text: Audio.source.name
            }

            Rectangle {
                implicitHeight: 2
                Layout.fillWidth: true
            }

            Text {
                text: "Sinks"
            }
            Repeater {
                model: Audio.sinks
                Text {
                    required property PwNode modelData
                    visible: Audio.sink.node != modelData
                    text: modelData.description

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Audio.setSink(parent.modelData)
                    }
                }
            }
            Text {
                text: "Sources"
            }
            Repeater {
                model: Audio.sources
                Text {
                    required property PwNode modelData
                    visible: Audio.source.node != modelData
                    text: modelData.description

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Audio.setSource(parent.modelData)
                    }
                }
            }
        }
    }
}
