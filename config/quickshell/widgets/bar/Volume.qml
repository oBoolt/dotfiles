import Quickshell
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.helpers
import qs.widgets.common

Card {
    id: root
    required property PwNode node
    readonly property bool muted: node.audio?.muted
    icon: Audio.getAudioIcon(node)

    color: muted ? Colors.red : Colors.darkaqua
}
