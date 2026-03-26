pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

import QtQuick
import qs.utils

Singleton {
    id: root

    function getAudioIcon(volume: real, muted: bool): int {
        if (muted) {
            return Icons.AudioVolumeMutedSymbolic;
        }
        if (volume >= 0.66) {
            return Icons.AudioVolumeHighSymbolic;
        } else if (volume >= 0.33) {
            return Icons.AudioVolumeMediumSymbolic;
        } else if (volume >= 0) {
            return Icons.AudioVolumeLowSymbolic;
        }
    }

    function setSink(node: PwNode): void {
        if (node.isSink && !node.isStream && node.audio) {
            Pipewire.preferredDefaultAudioSink = node;
        }
    }

    function setSource(node: PwNode): void {
        if (!node.isSink && !node.isStream && node.audio) {
            Pipewire.preferredDefaultAudioSource = node;
        }
    }

    component PwNodeWrapper: QtObject {
        required property PwNode node
        readonly property bool muted: !!node?.audio?.muted
        readonly property real volume: node?.audio?.volume ?? 0
        readonly property bool ready: node?.ready ?? false
        readonly property string name: node?.description || node?.nickname || node?.name || "Unknown Device"
        property int icon

        onVolumeChanged: {
            icon = root.getAudioIcon(volume, muted);
        }

        onMutedChanged: {
            icon = root.getAudioIcon(volume, muted);
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

    readonly property list<PwNode> sinks: {
        return Pipewire.nodes.values.filter(n => n.isSink && !n.isStream && n.audio);
    }

    readonly property list<PwNode> sources: {
        return Pipewire.nodes.values.filter(n => !n.isSink && !n.isStream && n.audio);
    }

    readonly property PwNodeWrapper sink: PwNodeWrapper {
        node: Pipewire.defaultAudioSink
    }
    readonly property PwNodeWrapper source: PwNodeWrapper {
        node: Pipewire.defaultAudioSource
    }

    PwObjectTracker {
        objects: [...root.sinks, ...root.sources]
    }
}
