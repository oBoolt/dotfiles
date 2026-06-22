import QtQuick
import QtQuick.Layouts

import Quickshell.Networking

import qs.components
import qs.services
import qs.appearance

Page {
    id: root
    title: "Network"
    rightArea: Toggle {
        Layout.preferredHeight: Appearance.font.icon
        Layout.preferredWidth: height * 2
        active: NetworkManager.wifiEnabled
        onToggled: NetworkManager.toggleWifi()
    }

    ListView {
        id: list
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        spacing: Appearance.spacing.small
        model: NetworkManager.devices
        delegate: Item {
            id: listItem
            required property NetworkDevice modelData
            readonly property bool connected: modelData.connected

            implicitWidth: ListView.view.width
            implicitHeight: 32

            Rectangle {
                anchors.fill: parent
                color: listItem.connected ? Colors.main : Colors.containerMute
            }

            Text {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Qt.AlignVCenter
                font.bold: false
                text: listItem.modelData.name
            }
        }
    }

    Text {
        text: NetworkManager.currentConnection?.name ?? "Disconnected"
    }
}
