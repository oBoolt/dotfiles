pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    property BluetoothAdapter currentAdapter: Bluetooth.defaultAdapter
    readonly property bool blocked: (currentAdapter?.state == BluetoothAdapterState.Blocked) ?? false
    readonly property bool loading: (currentAdapter?.state == BluetoothAdapterState.Enabling || currentAdapter?.state == BluetoothAdapterState.Disabling) ?? false
    readonly property bool enabled: (currentAdapter?.state == BluetoothAdapterState.Enabled) ?? false

    readonly property list<BluetoothDevice> connectedDevices: {
        return root.currentAdapter?.devices.values.filter(d => d.connected) ?? [];
    }

    readonly property list<BluetoothDevice> pairedDevices: {
        return root.currentAdapter?.devices.values.filter(d => d.paired && !d.connected) ?? [];
    }

    readonly property list<BluetoothDevice> unknownDevices: {
        return root.currentAdapter?.devices.values.filter(d => !d.connected && !d.paired) ?? [];
    }

    readonly property list<BluetoothDevice> sortedDevices: [...connectedDevices, ...pairedDevices, ...unknownDevices]

    function toggleDiscovering() {
        if (!root.enabled)
            return;
        root.currentAdapter.discovering = !root.currentAdapter.discovering;
    }

    function toggleEnabled() {
        if (currentAdapter == null)
            return;

        root.currentAdapter.enabled = !root.currentAdapter.enabled;
    }
}
