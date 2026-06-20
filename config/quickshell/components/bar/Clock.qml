import QtQuick

import qs.components
import qs.utils
import qs.services
import qs.modules

Text {
    required property QtObject parentWindow
    text: `${Time.hours}:${Time.minutes}`

    MouseArea {
        anchors.fill: parent
        onClicked: () => {
            States.updateCurrentScreen();
            ModulesState.toggleCalendar();
        }
    }
}
