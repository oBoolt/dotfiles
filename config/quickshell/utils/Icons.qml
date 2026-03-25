pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    enum Enum {
        BatteryFullChargedSymbolic,
        BatteryFullChargingSymbolic,
        BatteryGoodChargingSymbolic,
        BatteryLowChargingSymbolic,
        BatteryCautionChargingSymbolic,
        BatteryEmptyChargingSymbolic,
        BatteryFullSymbolic,
        BatteryGoodSymbolic,
        BatteryLowSymbolic,
        BatteryCautionSymbolic,
        BatteryEmptySymbolic,
        BatteryMissingSymbolic,
        AudioVolumeHighSymbolic,
        AudioVolumeMediumSymbolic,
        AudioVolumeLowSymbolic,
        AudioVolumeMutedSymbolic,
        BluetoothActiveSymbolic,
        BluetoothDisabledSymbolic,
        NetworkWiredActivatedSymbolic,
        NetworkWiredDisconnectedSymbolic,
        NetworkWiredUnavailableSymbolic,
        NetworkWirelessSignalNoneSymbolic,
        NetworkWirelessSignalWeakSymbolic,
        NetworkWirelessSignalOkSymbolic,
        NetworkWirelessSignalGoodSymbolic,
        NetworkWirelessSignalExcellentSymbolic,
        NetworkWirelessDisconnectedSymbolic,
        NetworkWirelessAcquiringSymbolic,
        Brightness0Symbolic,
        Brightness15Symbolic,
        Brightness30Symbolic,
        Brightness45Symbolic,
        Brightness60Symbolic,
        Brightness75Symbolic,
        Brightness90Symbolic,
        OpenMenuSymbolic,
        MediaPlaybackPauseSymbolic,
        MediaPlaybackStartSymbolic,
        MediaSkipBackwardSymbolic,
        MediaSkipForwardSymbolic,
        GoNextSymbolicRtl,
        GoNextSymbolic,
        SystemShutdownSymbolic,
        SystemLockScreenSymbolic,
        ApplicationExitSymbolic
    }

    function get(icon: int): string {
        // return Quickshell.iconPath(Qt.enumValueToString(Icons.Enum, icon).replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase());
        return Quickshell.iconPath("media-skip-forward-symbolic");
    }

    function getKey(iconName: string): int {
        let icon = iconName.replace(/(^\w|-\w)/g, t => {
            return t.replace(/-/, "").toUpperCase();
        });
        return Icons[icon];
    }

    function getBrightnessIcon(percentage: real): int {
        if (percentage >= 0.9) {
            return Icons.Brightness90Symbolic;
        } else if (percentage >= 0.75) {
            return Icons.Brightness75Symbolic;
        } else if (percentage >= 0.6) {
            return Icons.Brightness60Symbolic;
        } else if (percentage >= 0.45) {
            return Icons.Brightness45Symbolic;
        } else if (percentage >= 0.30) {
            return Icons.Brightness30Symbolic;
        } else if (percentage >= 0.15) {
            return Icons.Brightness15Symbolic;
        } else {
            return Icons.Brightness0Symbolic;
        }
    }

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
}
