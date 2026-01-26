import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire

import QtQuick

import qs.types
import qs.helpers
import qs.services
import qs.windows as Windows

import qs.settings

ShellRoot {
    NotificationServer {
        id: notificationServer
        bodySupported: true
        imageSupported: true

        onNotification: not => {
            not.tracked = true;
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            let node = Pipewire.defaultAudioSink;
            let volume = Math.round(node?.audio?.volume * 100) ?? 0;
            osd.showOSD(OsdMode.Audio, Audio.getAudioIcon(node), volume);
        }
        function onMutedChanged() {
            let node = Pipewire.defaultAudioSink;
            let volume = Math.round(node?.audio?.volume * 100) ?? 0;
            osd.showOSD(OsdMode.Audio, Audio.getAudioIcon(node), volume);
        }
    }

    Connections {
        target: Brightness
        function onCurrentChanged() {
            osd.showOSD(OsdMode.Brightness, Brightness.icon, Math.round(Brightness.percentage * 100));
        }
    }

    LazyLoader {
        active: Config.bar.enabled
        Windows.Bar {}
    }

    Windows.Notifications {
        notificationServer: notificationServer
    }

    Windows.OSD {
        id: osd
    }

    Windows.ControlCenter {}
    Windows.Calendar {}

    Component.onCompleted: {
        Brightness.updateIcon();
    }
}
