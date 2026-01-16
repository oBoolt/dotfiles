import Quickshell.Services.UPower

import QtQuick
import QtQml

import qs.helpers
import qs.widgets

Card {
    id: root
    readonly property UPowerDevice laptop: UPower.displayDevice

    visible: UPower.displayDevice.isLaptopBattery
    icon: Icons.getKey(laptop.iconName)
    value: Math.round(laptop.percentage * 100) + "%"
    color: Battery.getColor(Icons.getKey(laptop.iconName))
}
