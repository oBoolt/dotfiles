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
        NetworkBluetoothSymbolic,
        NetworkBluetoothActivatedSymbolic,
        NetworkBluetoothInactiveSymbolic,
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
        CPU,
        OpenMenuSymbolic,
        MediaPlaybackPauseSymbolic,
        MediaPlaybackStartSymbolic,
        MediaSkipBackwardSymbolic,
        MediaSkipForwardSymbolic,
        GoNextSymbolicRtl,
        GoNextSymbolic
    }
    readonly property var map: {
        let map = new Map();
        map.set(Icons.BatteryFullChargedSymbolic, "battery-full-charged-symbolic");
        map.set(Icons.BatteryFullChargingSymbolic, "battery-full-charging-symbolic");
        map.set(Icons.BatteryGoodChargingSymbolic, "battery-good-charging-symbolic");
        map.set(Icons.BatteryLowChargingSymbolic, "battery-low-charging-symbolic");
        map.set(Icons.BatteryCautionChargingSymbolic, "battery-caution-charging-symbolic");
        map.set(Icons.BatteryEmptyChargingSymbolic, "battery-empty-charging-symbolic");
        map.set(Icons.BatteryFullSymbolic, "battery-full-symbolic");
        map.set(Icons.BatteryGoodSymbolic, "battery-good-symbolic");
        map.set(Icons.BatteryLowSymbolic, "battery-low-symbolic");
        map.set(Icons.BatteryCautionSymbolic, "battery-caution-symbolic");
        map.set(Icons.BatteryEmptySymbolic, "battery-empty-symbolic");
        map.set(Icons.BatteryMissingSymbolic, "battery-missing-symbolic");
        map.set(Icons.AudioVolumeHighSymbolic, "audio-volume-high-symbolic");
        map.set(Icons.AudioVolumeMediumSymbolic, "audio-volume-medium-symbolic");
        map.set(Icons.AudioVolumeLowSymbolic, "audio-volume-low-symbolic");
        map.set(Icons.AudioVolumeMutedSymbolic, "audio-volume-muted-symbolic");
        map.set(Icons.NetworkBluetoothSymbolic, "network-bluetooth-symbolic");
        map.set(Icons.NetworkBluetoothActivatedSymbolic, "network-bluetooth-activated-symbolic");
        map.set(Icons.NetworkBluetoothInactiveSymbolic, "network-bluetooth-inactive-symbolic");
        map.set(Icons.NetworkWiredActivatedSymbolic, "network-wired-activated-symbolic");
        map.set(Icons.NetworkWiredDisconnectedSymbolic, "network-wired-disconnected-symbolic");
        map.set(Icons.NetworkWiredUnavailableSymbolic, "network-wired-unavailable-symbolic");
        map.set(Icons.NetworkWirelessSignalNoneSymbolic, "network-wireless-signal-noneSymbolic");
        map.set(Icons.NetworkWirelessSignalWeakSymbolic, "network-wireless-signal-weakSymbolic");
        map.set(Icons.NetworkWirelessSignalOkSymbolic, "network-wireless-signal-okSymbolic");
        map.set(Icons.NetworkWirelessSignalGoodSymbolic, "network-wireless-signal-goodSymbolic");
        map.set(Icons.NetworkWirelessSignalExcellentSymbolic, "network-wireless-signal-excellentSymbolic");
        map.set(Icons.NetworkWirelessDisconnectedSymbolic, "network-wireless-disconnected-symbolic");
        map.set(Icons.NetworkWirelessAcquiringSymbolic, "network-wireless-acquiring-symbolic");
        map.set(Icons.Brightness0Symbolic, "brightness-0-symbolic");
        map.set(Icons.Brightness15Symbolic, "brightness-15-symbolic");
        map.set(Icons.Brightness30Symbolic, "brightness-30-symbolic");
        map.set(Icons.Brightness45Symbolic, "brightness-45-symbolic");
        map.set(Icons.Brightness60Symbolic, "brightness-60-symbolic");
        map.set(Icons.Brightness75Symbolic, "brightness-75-symbolic");
        map.set(Icons.Brightness90Symbolic, "brightness-90-symbolic");
        map.set(Icons.CPU, "cpu");
        map.set(Icons.OpenMenuSymbolic, "open-menu-symbolic");
        map.set(Icons.MediaPlaybackPauseSymbolic, "media-playback-pause-symbolic");
        map.set(Icons.MediaPlaybackStartSymbolic, "media-playback-start-symbolic");
        map.set(Icons.MediaSkipBackwardSymbolic, "media-skip-backward-symbolic");
        map.set(Icons.MediaSkipForwardSymbolic, "media-skip-forward-symbolic");
        map.set(Icons.GoNextSymbolicRtl, "go-next-symbolic-rtl");
        map.set(Icons.GoNextSymbolic, "go-next-symbolic");
        return map;
    }

    function get(icon: int): string {
        return Quickshell.iconPath(root.map.get(icon));
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
