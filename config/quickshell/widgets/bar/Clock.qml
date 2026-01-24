import QtQuick

import qs.widgets

import qs.helpers
import qs.utils

Text {
    required property QtObject parentWindow
    text: `${Time.hours}:${Time.minutes}`

    MouseArea {
        anchors.fill: parent
        onClicked: () => {
            States.showCalendar = !States.showCalendar;
        }
    }
}
