import QtQuick

import qs.components
import qs.utils

Text {
    required property QtObject parentWindow
    text: `${Time.hours}:${Time.minutes}`

    MouseArea {
        anchors.fill: parent
        onClicked: () => {
            States.updateCurrentScreen();
            States.toggleCalendar();
        }
    }
}
