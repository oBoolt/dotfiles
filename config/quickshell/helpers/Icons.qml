pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    enum Enum {
        BatteryFullChargedSymbolic,
        BatteryFullChargingSymbolic,
        BatteryGoodChargingSymbolic,
        BatteryLowChargingSymbolic,
        BatteryCautionChargingSymbolic,
        BatteryEmptyChargingSymbolic,
        BatteryFullSymbolic,
        BatteryGoodSymbolic,
        BatteryLowSymbolic,
        BatteryCautionSymbolic,
        BatteryEmptySymbolic,
        BatteryMissingSymbolic,
        AudioVolumeHighSymbolic,
        AudioVolumeMediumSymbolic,
        AudioVolumeLowSymbolic,
        AudioVolumeMutedSymbolic,
        AudioVolumeOffSymbolic,
        NetworkBluetoothSymbolic,
        NetworkBluetoothActivatedSymbolic,
        NetworkBluetoothInactiveSymbolic,
        NetworkWiredActivatedSymbolic,
        NetworkWiredDisconnectedSymbolic,
        NetworkWiredUnavailableSymbolic,
        NetworkWirelessSignalNoneSymbolic,
        NetworkWirelessSignalWeakSymbolic,
        NetworkWirelessSignalOkSymbolic,
        NetworkWirelessSignalGoodSymbolic,
        NetworkWirelessSignalExcellentSymbolic,
        NetworkWirelessDisconnectedSymbolic,
        NetworkWirelessAcquiringSymbolic,
        Brightness0Symbolic,
        Brightness15Symbolic,
        Brightness30Symbolic,
        Brightness45Symbolic,
        Brightness60Symbolic,
        Brightness75Symbolic,
        Brightness90Symbolic,
        CPU
    }
    readonly property var map: {
        let map = new Map();
        map.set(Icons.BatteryFullChargedSymbolic, "󰁹");
        map.set(Icons.BatteryFullChargingSymbolic, "󰂄");
        map.set(Icons.BatteryGoodChargingSymbolic, "󰂄");
        map.set(Icons.BatteryLowChargingSymbolic, "󰂄");
        map.set(Icons.BatteryCautionChargingSymbolic, "󰂄");
        map.set(Icons.BatteryEmptyChargingSymbolic, "󰂄");
        map.set(Icons.BatteryFullSymbolic, "󰁹");
        map.set(Icons.BatteryGoodSymbolic, "󰁿");
        map.set(Icons.BatteryLowSymbolic, "󰁻");
        map.set(Icons.BatteryCautionSymbolic, "󰂃");
        map.set(Icons.BatteryEmptySymbolic, "󰂎");
        map.set(Icons.BatteryMissingSymbolic, "󰂑");
        map.set(Icons.AudioVolumeHighSymbolic, "󰕾");
        map.set(Icons.AudioVolumeMediumSymbolic, "󰖀");
        map.set(Icons.AudioVolumeLowSymbolic, "󰕿");
        map.set(Icons.AudioVolumeMutedSymbolic, "󰝟");
        map.set(Icons.AudioVolumeOffSymbolic, "󰸈");
        map.set(Icons.NetworkBluetoothSymbolic, "󰂯");
        map.set(Icons.NetworkBluetoothActivatedSymbolic, "󰂱");
        map.set(Icons.NetworkBluetoothInactiveSymbolic, "󰂲");
        map.set(Icons.NetworkWiredActivatedSymbolic, "󰛳");
        map.set(Icons.NetworkWiredDisconnectedSymbolic, "󰲛");
        map.set(Icons.NetworkWiredUnavailableSymbolic, "󰲝");
        map.set(Icons.NetworkWirelessSignalNoneSymbolic, "󰤯");
        map.set(Icons.NetworkWirelessSignalWeakSymbolic, "󰤟");
        map.set(Icons.NetworkWirelessSignalOkSymbolic, "󰤢");
        map.set(Icons.NetworkWirelessSignalGoodSymbolic, "󰤥");
        map.set(Icons.NetworkWirelessSignalExcellentSymbolic, "󰤨");
        map.set(Icons.NetworkWirelessDisconnectedSymbolic, "󰤭");
        map.set(Icons.NetworkWirelessAcquiringSymbolic, "󰖩");
        map.set(Icons.Brightness0Symbolic, "󰃚");
        map.set(Icons.Brightness15Symbolic, "󰃛");
        map.set(Icons.Brightness30Symbolic, "󰃜");
        map.set(Icons.Brightness45Symbolic, "󰃝");
        map.set(Icons.Brightness60Symbolic, "󰃞");
        map.set(Icons.Brightness75Symbolic, "󰃟");
        map.set(Icons.Brightness90Symbolic, "󰃠");
        map.set(Icons.CPU, "󰍛");
        return map;
    }

    function get(icon: int): string {
        return root.map.get(icon);
    }

    function getKey(iconName: string): int {
        let icon = iconName.replace(/(^\w|-\w)/g, t => {
            return t.replace(/-/, "").toUpperCase();
        });
        return Icons[icon];
    }
    Component.onCompleted: () => {}
}
