import QtQuick

import qs.services
import qs.components
import qs.config

Button {
    icon: NetworkManager.icon
    background.hover: true
    color: NetworkManager.connected ? Colors.foreground : Colors.danger
}
