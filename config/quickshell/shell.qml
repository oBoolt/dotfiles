import Quickshell
import Quickshell.Services.Notifications

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

    Connections {
        target: Audio.sink
        function onVolumeChanged() {
            osd.showOSD(OsdMode.Audio, Audio.sink.icon, Math.round(Audio.sink.volume * 100));
        }
        function onMutedChanged() {
            osd.showOSD(OsdMode.Audio, Audio.sink.icon, Math.round(Audio.sink.volume * 100));
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
}
