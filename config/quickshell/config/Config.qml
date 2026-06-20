pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
    id: root
    property alias debug: adapter.debug
    property alias locale: adapter.locale
    property alias wallpaperIndex: adapter.wallpaperIndex
    property int wallpapersSize: 0

    property alias modules: adapter.modules
    property AppearanceConfig appearance: AppearanceConfig {}
    property alias paths: adapter.paths
    property alias notification: adapter.notification
    property alias osd: adapter.osd
    property alias brightness: adapter.brightness
    property alias controlcenter: adapter.controlcenter
    property alias bar: adapter.bar

    function setWallpaper(index: int): void {
        root.wallpaperIndex = index % wallpapersSize;
        fileView.writeAdapter();
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
            property int wallpaperIndex: 0

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
