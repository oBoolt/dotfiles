import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import QtQuick // qmllint disable

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

    Background {}
    LockScreen {}

    Variants {
        id: popupsWrapper
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
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Overlay
            mask: Region {
                Region {
                    item: ModulesState.showNotifications ? notificationsItem : null
                }
                Region {
                    item: ModulesState.showAreaPicker ? areaPickerItem : null
                }
            }

            Notifications {
                id: notificationsItem
            }
            AreaPicker {
                id: areaPickerItem
            }
            Osd {}
        }
    }

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
            SystemTray {
                id: systemTrayItem
            }

            Component.onCompleted: States.barZone = Config.modules.bar ? itemRect(barItem).height : 0
        }
    }
}
