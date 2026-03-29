import QtQuick

import qs.components
import qs.utils

Card {
    icon: Icons.OpenMenuSymbolic

    onClicked: {
        States.updateCurrentScreen();
        States.toggleControlCenter();
    }
}
