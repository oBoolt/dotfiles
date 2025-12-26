pragma Singleton

import Quickshell
import QtQuick

import qs.settings

Singleton {
    id: root
    readonly property var colorMap: {
        let map = new Map();
        map.set(Icons.BatteryFullChargedSymbolic, Colors.purple);
        map.set(Icons.BatteryFullChargingSymbolic, Colors.aqua);
        map.set(Icons.BatteryGoodChargingSymbolic, Colors.darkaqua);
        map.set(Icons.BatteryLowChargingSymbolic, Colors.darkaqua);
        map.set(Icons.BatteryCautionChargingSymbolic, Colors.red);
        map.set(Icons.BatteryEmptyChargingSymbolic, Colors.red);
        map.set(Icons.BatteryFullSymbolic, Colors.purple);
        map.set(Icons.BatteryGoodSymbolic, Colors.darkpurple);
        map.set(Icons.BatteryLowSymbolic, Colors.orange);
        map.set(Icons.BatteryCautionSymbolic, Colors.darkred);
        map.set(Icons.BatteryEmptySymbolic, Colors.darkred);
        map.set(Icons.BatteryMissingSymbolic, Colors.gray);
        return map;
    }

    function getColor(icon: int): color {
        return root.colorMap.get(icon);
    }
}
