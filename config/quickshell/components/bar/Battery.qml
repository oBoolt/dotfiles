import Quickshell.Services.UPower

import QtQuick
import QtQml

import qs.utils
import qs.components
import qs.config

Card {
    id: root
    readonly property UPowerDevice laptop: UPower.displayDevice

    function getIcon(percent: real): int {
        if (percent == 1)
            return Icons.BatteryLevel100Symbolic;
        else if (percent >= 0.9)
            return Icons.BatteryLevel90Symbolic;
        else if (percent >= 0.8)
            return Icons.BatteryLevel80Symbolic;
        else if (percent >= 0.7)
            return Icons.BatteryLevel70Symbolic;
        else if (percent >= 0.6)
            return Icons.BatteryLevel60Symbolic;
        else if (percent >= 0.5)
            return Icons.BatteryLevel50Symbolic;
        else if (percent >= 0.4)
            return Icons.BatteryLevel40Symbolic;
        else if (percent >= 0.3)
            return Icons.BatteryLevel30Symbolic;
        else if (percent >= 0.2)
            return Icons.BatteryLevel20Symbolic;
        else if (percent >= 0.1)
            return Icons.BatteryLevel10Symbolic;
        else if (percent >= 0)
            return Icons.BatteryLevel0Symbolic;

        return Icons.BatteryMissingSymbolic;
    }

    function getColor(percent: real): color {
        if (percent >= 0.9)
            return Colors.darkgreen;
        if (percent >= 0.7)
            return Colors.green;
        if (percent >= 0.5)
            return Colors.yellow;
        if (percent >= 0.2)
            return Colors.red;
        if (percent >= 0)
            return Colors.darkred;
    }

    visible: laptop.isLaptopBattery
    icon: root.getIcon(laptop.percentage)
    color: root.getColor(laptop.percentage)
}
