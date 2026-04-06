import QtQuick

import qs.components
import qs.utils

Button {
    icon: Icons.OpenMenuSymbolic
    background.hover: true

    onClicked: {
        States.updateCurrentScreen();
        States.toggleControlCenter();
    }
}
