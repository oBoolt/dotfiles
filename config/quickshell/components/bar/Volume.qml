import QtQuick

import qs.config
import qs.services
import qs.components

Button {
    icon: Audio.sink.icon
    color: Audio.sink.muted ? Colors.danger : Colors.foreground
    background.hover: true

    onClicked: {
        Audio.sink.toggleMute();
    }

    onWheel: e => {
        Audio.sink.setVolume(Audio.sink.volume + (e.angleDelta.y < 0 ? (-0.05) : 0.05));
    }
}
