import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.config

LazyLoader {
    active: Config.modules.background

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property ShellScreen modelData
            property list<string> wallpapers: getWallpapers()
            property int currentWallpaperIndex: 3

            function getWallpapers(): var {
                return ["hk-1-3840_2160", "hk-2-3840_4006", "hk-3_4000_2250", "hk-4-3840_2160"];
            }

            screen: modelData
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: Qt.resolvedUrl(Quickshell.env("XDG_CONFIG_HOME") + "/wallpapers/" + root.wallpapers[root.currentWallpaperIndex] + ".jpg")
            }
        }
    }
}
