import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import QtQuick // qmllint disable

import qs.services
import qs.modules
import qs.config
import qs.utils

ShellRoot {
    NotificationServer {
        bodySupported: true
        imageSupported: true

        onNotification: not => {
            not.tracked = true;
        }

        Component.onCompleted: States.notificationServer = this
    }

    HyprlandFocusGrab {
        windows: windowsWrapper.instances
        active: States.isPopupOpen
        onCleared: States.closeAll()
    }

    GlobalShortcuts {}

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

    OSD {
        id: osd
    }
    Background {}
    LockScreen {}

    Variants {
        id: windowsWrapper
        model: Quickshell.screens

        PanelWindow { // qmllint disable uncreatable-type
            required property ShellScreen modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: screen.height
            color: "transparent"
            exclusiveZone: Config.modules.bar ? itemRect(barItem).height : 0
            mask: Region {
                Region {
                    item: Config.modules.bar ? barItem : null
                }
                Region {
                    item: (Config.modules.mpris && States.showMpris) ? mprisItem : null
                }
                Region {
                    item: (Config.modules.controlcenter && States.showControlCenter) ? controlCenterItem : null
                }
                Region {
                    item: (Config.modules.calendar && States.showCalendar) ? calendarItem : null
                }
                Region {
                    item: (Config.modules.notifications && States.notificationServer?.trackedNotifications.values.length > 0) ? notificationsItem : null
                }
            }

            Bar {
                id: barItem
            }
            Mpris {
                id: mprisItem
            }
            ControlCenter {
                id: controlCenterItem
            }
            Calendar {
                id: calendarItem
            }
            Notifications {
                id: notificationsItem
            }

            Component.onCompleted: States.barZone = Config.modules.bar ? itemRect(barItem).height : 0
        }
    }
}
