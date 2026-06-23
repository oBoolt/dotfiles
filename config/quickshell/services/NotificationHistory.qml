pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.types

Singleton {
    id: root
    property list<SimpleNotification> notifications: []
    property bool _loaded: false

    onNotificationsChanged: {
        if (root._loaded)
            fileView.update();
    }

    function push(summary: string, body: string, appName: string): void {
        let cmp = Qt.createComponent("../types/SimpleNotification.qml");
        let not = {
            summary,
            body,
            appName,
            date: new Date()
        };
        let obj = cmp.createObject(root, not);
        root.notifications.push(obj);
    }

    function remove(date: date): void {
        root.notifications = Array.from(root.notifications).filter(c => c.date.getTime() != date.getTime());
    }

    FileView {
        id: fileView
        path: Qt.resolvedUrl(Quickshell.dataDir + "/history.json")

        function update(): bool {
            fileView.setText(JSON.stringify(root.notifications, (key, value) => {
                if (key === "objectName")
                    return undefined;

                return value;
            }, 2));
        }

        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                fileView.update();
                root._loaded = true;
                return;
            }
        }

        onLoaded: {
            let foo = JSON.parse(fileView.text());
            for (let i = 0; i < foo.length; i++) {
                const c = foo[i];
                let cmp = Qt.createComponent("../types/SimpleNotification.qml");
                let not = {
                    summary: c.summary,
                    body: c.body,
                    appName: c.appName,
                    date: c.date
                };
                let obj = cmp.createObject(root, not);
                root.notifications.push(obj);
            }
            root._loaded = true;
        }
    }
}
