import Quickshell
import QtQuick

import qs.widgets.common
import qs.widgets.bar

import qs.helpers
import qs.settings

Text {
    id: root
    required property QtObject parentWindow
    text: `${Time.hours}:${Time.minutes}`

    MouseArea {
        anchors.fill: parent
        onClicked: () => {
            calendarLoader.item.visible = !calendarLoader.item.visible;
        }
    }

    LazyLoader {
        id: calendarLoader
        loading: true

        Calendar {
            anchor.window: root.parentWindow
        }
    }
}
