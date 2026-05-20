pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
    id: root
    readonly property bool found: Networking.backend != NetworkBackendType.None
    readonly property bool connected: !(Networking.connectivity == NetworkConnectivity.None || Networking.connectivity == NetworkConnectivity.Unknown)
    readonly property bool wifiEnabled: Networking.wifiEnabled

    readonly property list<WifiDevice> wifiDevices: Networking.devices.values.filter(dev => dev.type == DeviceType.Wifi)
    readonly property list<WiredDevice> wiredDevices: Networking.devices.values.filter(dev => dev.type == DeviceType.Wired)
    readonly property list<NetworkDevice> devices: [...wiredDevices, ...wifiDevices]

    readonly property NetworkDevice currentDevice: devices.find(dev => dev.connected) ?? null
    readonly property Network currentConnection: {
        let current = root.currentDevice;
        if (current == null)
            return null;
        if (current.type == DeviceType.Wired)
            return (current as WiredDevice).network;

        if (current.type == DeviceType.Wifi) {
            return current.networks.values.find(con => con.connected);
        }
    }

    function toggleWifi(): void {
        Networking.wifiEnabled = !Networking.wifiEnabled;
    }
}
