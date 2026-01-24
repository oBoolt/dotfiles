pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
    property alias debug: adapter.debug
    property alias locale: adapter.locale

    property alias appearance: adapter.appearance
    property alias bar: adapter.bar
    property alias paths: adapter.paths
    property alias notification: adapter.notification
    property alias osd: adapter.osd
    property alias calendar: adapter.calendar
    property alias controlcenter: adapter.controlcenter

    FileView {
        id: fileView
        path: Qt.resolvedUrl(Quickshell.dataDir + "/config.json")
        watchChanges: true

        onFileChanged: reload()
        onAdapterChanged: writeAdapter()
        onLoadFailed: error => {
            if (error = FileViewError.FileNotFound) {
                fileView.createFile();
                console.info("config file created");
            }
        }

        function createFile(): bool {
            fileView.setText(JSON.stringify(adapter, null, 2));
        }

        JsonAdapter {
            id: adapter
            property bool debug: false
            property string locale: "en_US"

            property AppearanceConfig appearance: AppearanceConfig {}
            property BarConfig bar: BarConfig {}
            property PathsConfig paths: PathsConfig {}
            property NotificationConfig notification: NotificationConfig {}
            property OSDConfig osd: OSDConfig {}
            property CalendarConfig calendar: CalendarConfig {}
            property ControlCenterConfig controlcenter: ControlCenterConfig {}
        }
    }
}
