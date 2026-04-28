import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Pipewire

import qs.services
import qs.components
import qs.config
import qs.utils

Page {
    id: root
    component NodeList: ListView {
        id: listView
        required property PwNode currentNode

        clip: true
        spacing: Appearance.spacing.small
        delegate: Item {
            id: listItem
            required property PwNode modelData
            required property int index
            readonly property string name: modelData?.description || modelData?.nickname || modelData?.name || "Unknown Device"
            readonly property bool isCurrentItem: ListView.isCurrentItem

            implicitWidth: ListView.view.width
            implicitHeight: 32

            Rectangle {
                anchors.fill: parent
                opacity: 0.5
                color: listItem.isCurrentItem ? Colors.main : Colors.container
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                spacing: 0

                // Icon {
                //     Layout.fillHeight: true
                //     Layout.preferredWidth: height
                //     implicitSize: width / 2
                //     icon: Icons.AudioVolumeHighSymbolic
                // }

                Text {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Qt.AlignVCenter
                    font.bold: false
                    text: listItem.name
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Audio.setNode(listItem.modelData);
                    listItem.ListView.view.currentIndex = listItem.index;
                }
            }
        }

        Component.onCompleted: this.currentIndex = this.model.findIndex(node => node == listView.currentNode)
    }

    component ListHeader: RowLayout {
        id: headerItem
        required property string text
        required property int icon

        Icon {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            Layout.alignment: Qt.AlignVCenter
            implicitSize: width * 0.75
            icon: headerItem.icon
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Qt.AlignVCenter
            fontSizeMode: Text.VerticalFit
            font.pixelSize: 999
            text: headerItem.text
        }
    }

    ListHeader {
        Layout.fillWidth: true
        Layout.maximumHeight: Appearance.font.large * 1.25
        icon: Icons.AudioHeadphonesSymbolic
        text: "Sinks"
    }

    NodeList {
        Layout.fillHeight: true
        Layout.fillWidth: true
        model: Audio.sinks
        currentNode: Audio.sink.node
    }

    ListHeader {
        Layout.fillWidth: true
        Layout.maximumHeight: Appearance.font.large * 1.25
        icon: Icons.AudioInputMicrophoneSymbolic
        text: "Sources"
    }

    NodeList {
        Layout.fillHeight: true
        Layout.fillWidth: true
        model: Audio.sources
        currentNode: Audio.source.node
    }

    Button {
        Layout.preferredHeight: Appearance.font.icon
        hoverEnabled: true
        background.hover: true
        text: "Back"
        icon: Icons.GoPreviousSymbolic
        onClicked: root.pop()
    }
}
