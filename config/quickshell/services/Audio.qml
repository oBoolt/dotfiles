pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

import QtQuick
import qs.helpers

Singleton {
    id: root
    component PwNodeWrapper: QtObject {
        required property PwNode node
        readonly property bool muted: !!node?.audio?.muted
        readonly property real volume: node?.audio?.volume ?? 0
        readonly property bool ready: node?.ready ?? false
        property int icon

        onVolumeChanged: {
            icon = Icons.getAudioIcon(volume, muted);
        }

        onMutedChanged: {
            icon = Icons.getAudioIcon(volume, muted);
        }

        function toggleMute(): void {
            if (!ready && node.audio)
                return;
            node.audio.muted = !node.audio.muted;
        }

        function setVolume(value: real): void {
            if (!ready && node.audio)
                return;
            let v = Math.max(0, Math.min(value, 1));
            node.audio.volume = v;
        }
    }

    readonly property PwNodeWrapper sink: PwNodeWrapper {
        node: Pipewire.defaultAudioSink
    }
    readonly property PwNodeWrapper source: PwNodeWrapper {
        node: Pipewire.defaultAudioSource
    }

    PwObjectTracker {
        objects: [root.sink.node, root.source.node]
    }
}
