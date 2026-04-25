import QtQuick

import qs.components
import qs.config
import qs.services
import qs.utils

Button {
    icon: BluetoothManager.enabled ? Icons.BluetoothSymbolic : Icons.BluetoothDisabledSymbolic
    color: BluetoothManager.enabled ? Colors.foreground : Colors.danger
    background.hover: true

    onClicked: BluetoothManager.toggleEnabled()
}
