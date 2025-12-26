pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    function getAudioIcon(node: PwNode): int {
        let muted = node?.audio?.muted;
        let volume = Math.round(node.audio?.volume * 100) ?? 0;
        if (muted) {
            return Icons.AudioVolumeMutedSymbolic;
        }
        if (volume >= 66) {
            return Icons.AudioVolumeHighSymbolic;
        } else if (volume >= 33) {
            return Icons.AudioVolumeMediumSymbolic;
        } else if (volume > 0) {
            return Icons.AudioVolumeLowSymbolic;
        } else if (volume == 0) {
            return Icons.AudioVolumeOffSymbolic;
        }
    }
}
