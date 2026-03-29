pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
    id: root
    property alias debug: adapter.debug
    property alias locale: adapter.locale
    property alias scaleFactor: adapter.scaleFactor
    property alias wallpaper: adapter.wallpaper

    property alias modules: adapter.modules
    property AppearanceConfig appearance: AppearanceConfig {}
    property alias paths: adapter.paths
    property alias notification: adapter.notification
    property alias osd: adapter.osd
    property alias brightness: adapter.brightness
    property alias controlcenter: adapter.controlcenter
    property alias bar: adapter.bar

    function setWallpaper(screen: ShellScreen, path: string) {
        root.wallpaper[screen.name] = path;
    }

    FileView {
        id: fileView
        path: Qt.resolvedUrl(Quickshell.dataDir + "/config.json")
        watchChanges: true

        onFileChanged: reload()
        onAdapterChanged: writeAdapter()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                fileView.createFile();
                console.info("config file created");
            }
        }

        function createFile(): bool {
            fileView.setText(JSON.stringify(adapter, (key, value) => {
                if (key === "objectName") {
                    return undefined;
                }
                return value;
            }, 2));
        }

        JsonAdapter {
            id: adapter
            property bool debug: false
            property string locale: "en_US"
            property var scaleFactor: {
                let result = {};
                for (let i = 0; i < Quickshell.screens.length; i++) {
                    let current = Quickshell.screens[i];
                    result[current.name] = 1;
                }

                return result;
            }
            property var wallpaper: {
                let result = {};
                let defaultPath = Quickshell.env("XDG_CONFIG_HOME") + "/wallpapers/default.jpg";
                for (let i = 0; i < Quickshell.screens.length; i++) {
                    result[Quickshell.screens[i].name] = defaultPath;
                }

                return result;
            }

            property ModulesConfig modules: ModulesConfig {}
            property PathsConfig paths: PathsConfig {}
            property NotificationConfig notification: NotificationConfig {}
            property OSDConfig osd: OSDConfig {}
            property BrightnessConfig brightness: BrightnessConfig {}
            property ControlCenterConfig controlcenter: ControlCenterConfig {}
            property BarConfig bar: BarConfig {}
        }
    }
}
