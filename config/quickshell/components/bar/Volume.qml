import QtQuick

import qs.settings
import qs.services
import qs.components

Card {
    id: root
    icon: Audio.sink.icon

    color: Audio.sink.muted ? Colors.red : Colors.darkaqua
}
