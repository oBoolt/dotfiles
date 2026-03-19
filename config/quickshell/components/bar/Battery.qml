import Quickshell.Services.UPower

import QtQuick
import QtQml

import qs.utils
import qs.components

Card {
    id: root
    readonly property UPowerDevice laptop: UPower.displayDevice

    visible: UPower.displayDevice.isLaptopBattery
    icon: Icons.getKey(laptop.iconName)
    color: Battery.getColor(Icons.getKey(laptop.iconName))
}
