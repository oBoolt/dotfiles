import QtQuick
import qs.components

import qs.utils

Button {
    icon: Icons.GoPreviousSymbolic
    rotation: States.showSystemTray ? 270 : 0

    onClicked: {
        States.showSystemTray = !States.showSystemTray;
    }
}
