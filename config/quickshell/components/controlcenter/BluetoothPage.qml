pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell.Bluetooth

import qs.components
import qs.utils
import qs.config
import qs.services

Page {
    id: root

    component DevicesList: ListView {
        id: listView
        clip: true
        spacing: Appearance.spacing.small
        delegate: Item {
            id: listItem

            required property BluetoothDevice modelData
            readonly property string name: modelData.name
            readonly property bool connected: modelData.connected
            readonly property bool paired: modelData.paired
            readonly property bool loading: (modelData.state == BluetoothDeviceState.Connecting) || (modelData.state == BluetoothDeviceState.Disconnecting)

            implicitWidth: ListView.view.width
            implicitHeight: 32

            Rectangle {
                anchors.fill: parent
                color: listItem.connected ? Colors.main : listItem.paired ? Colors.backgroundMuted : Colors.background
                opacity: listItem.loading ? 0.5 : 0.75
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                spacing: 0

                Icon {
                    readonly property bool hasIcon: !!listItem.modelData.icon
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    implicitSize: width * 0.5
                    iconString: hasIcon ? listItem.modelData.icon + "-symbolic" : Icons.getString(Icons.DialogQuestionSymbolic)
                }

                Text {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Qt.AlignVCenter
                    font.bold: false
                    text: listItem.name
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    visible: listItem.modelData.batteryAvailable
                    text: parseInt(listItem.modelData.battery * 100) + "%"
                }

                Icon {
                    visible: listItem.modelData.batteryAvailable
                    Layout.margins: Appearance.padding.small
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    implicitSize: width
                    icon: Icons.BatterySymbolic
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: listItem.loading ? Qt.WaitCursor : Qt.PointingHandCursor
                onClicked: {
                    if (listItem.loading)
                        return;

                    if (listItem.modelData.connected) {
                        listItem.modelData.disconnect();
                        return;
                    }

                    if (listItem.modelData.bonded) {
                        listItem.modelData.connect();
                        return;
                    }

                    listItem.modelData.pair();
                }
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.maximumHeight: Appearance.font.large * 1.25

        Icon {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            implicitSize: width * 0.75
            icon: 0
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Qt.AlignVCenter
            fontSizeMode: Text.VerticalFit
            font.pixelSize: 999
            text: BluetoothManager.currentAdapter?.adapterId ?? "Unknown Adapater"
        }

        Item {
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            color: BluetoothManager.currentAdapter?.discovering ? "green" : "red"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    BluetoothManager.toggleDiscovering();
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: height
            color: BluetoothManager.enabled ? "green" : "red"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    BluetoothManager.toggleEnabled();
                }
            }
        }
    }

    DevicesList {
        Layout.fillHeight: true
        Layout.fillWidth: true
        model: BluetoothManager.sortedDevices
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
