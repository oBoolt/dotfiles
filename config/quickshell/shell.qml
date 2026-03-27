import Quickshell
import Quickshell.Services.Notifications
import QtQuick

import qs.services
import qs.modules
import qs.config

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
            osd.showOSD(OSD.Audio, Audio.sink.icon, Math.round(Audio.sink.volume * 100));
        }
        function onMutedChanged() {
            osd.showOSD(OSD.Audio, Audio.sink.icon, Math.round(Audio.sink.volume * 100));
        }
    }

    Connections {
        target: Brightness
        function onCurrentChanged() {
            osd.showOSD(OSD.Brightness, Brightness.icon, Math.round(Brightness.percentage * 100));
        }
    }

    LazyLoader {
        active: Config.modules.bar
        Bar {}
    }

    Notifications {
        notificationServer: notificationServer
    }

    OSD {
        id: osd
    }

    ControlCenter {}
    Calendar {}
    Mpris {}
    Background {}
    LockScreen {}
}
