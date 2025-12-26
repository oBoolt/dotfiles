import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire

import QtQuick

import qs.types
import qs.helpers
import qs.windows as Windows

ShellRoot {
    NotificationServer {
        id: notificationServer
        onNotification: not => {
            console.info("Notification Received");
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

    Windows.Bar {}
    Windows.Launcher {}
    Windows.Notifications {
        notificationServer: notificationServer
    }
    Windows.OSD {
        id: osd
    }
}
