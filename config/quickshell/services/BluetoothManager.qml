pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    property BluetoothAdapter currentAdapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> connectedDevices: {
        return root.currentAdapter.devices.values.filter(d => d.connected);
    }

    readonly property list<BluetoothDevice> pairedDevices: {
        return root.currentAdapter.devices.values.filter(d => d.paired && !d.connected);
    }

    readonly property list<BluetoothDevice> unknownDevices: {
        return root.currentAdapter.devices.values.filter(d => !d.connected && !d.paired);
    }

    readonly property list<BluetoothDevice> sortedDevices: [...connectedDevices, ...pairedDevices, ...unknownDevices]
}
