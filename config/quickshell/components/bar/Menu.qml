import QtQuick

import qs.components
import qs.utils
import qs.modules

Button {
    icon: Icons.OpenMenuSymbolic
    background.hover: true

    onClicked: {
        States.updateCurrentScreen();
        ModulesState.toggleControlCenter();
    }
}
