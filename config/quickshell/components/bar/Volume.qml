import QtQuick

import qs.config
import qs.services
import qs.components

Card {
    id: root
    icon: Audio.sink.icon
    color: Audio.sink.muted ? Colors.danger : Colors.foreground

    onClicked: {
        Audio.sink.toggleMute();
    }
}
