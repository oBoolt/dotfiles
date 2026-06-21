import Quickshell
import Quickshell.Hyprland

import QtQuick // qmllint disable

import qs.services
import qs.config
import qs.modules
import qs.utils

ShellRoot {

    HyprlandFocusGrab {
        windows: windowsWrapper.instances
        active: ModulesState.isModuleOpen
        onCleared: ModulesState.closeAll()
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
    AreaPicker {}

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
                    item: ModulesState.showMpris ? mprisItem : null
                }
                Region {
                    item: ModulesState.showControlCenter ? controlCenterItem : null
                }
                Region {
                    item: ModulesState.showCalendar ? calendarItem : null
                }
                Region {
                    item: ModulesState.showSystemTray ? systemTrayItem : null
                }
                Region {
                    item: ModulesState.showNotifications ? notificationsItem : null
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
            SystemTray {
                id: systemTrayItem
            }

            Component.onCompleted: States.barZone = Config.modules.bar ? itemRect(barItem).height : 0
        }
    }
}
