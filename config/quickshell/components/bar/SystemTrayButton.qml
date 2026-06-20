import QtQuick
import qs.components

import qs.utils
import qs.modules

Button {
    icon: Icons.GoPreviousSymbolic
    rotation: ModulesState.showSystemTray ? 270 : 0

    onClicked: ModulesState.toggleSystemTray()
}
