import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Mpris

import qs.config
import qs.utils

LazyLoader {
    active: Config.modules.mpris && States.showMpris
    // active: true

    PanelWindow {
        screen: States.currentScreen
        exclusiveZone: 0

        anchors {
            top: true
        }

        margins {
            top: 8
        }

        implicitWidth: 450
        implicitHeight: 150

        Component.onCompleted: {
            console.log(JSON.stringify(Mpris.players));
        }
    }
}
