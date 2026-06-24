pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.types
import qs.config

Singleton {
    id: root
    property list<SimpleNotification> notifications: []
    property bool _loaded: false
    property bool _isEphemeral: false
    property SimpleNotification _current
    property list<SimpleNotification> ephemeral: []

    onNotificationsChanged: {
        if (root._isEphemeral) {
            root.ephemeral.push(root._current);
            root._isEphemeral = false;
            return;
        }

        if (root._loaded && Config.notification.history)
            fileView.update();
    }

    function _createSimpleNotification(summary: string, body: string, appName: string, urgency: int): QtObject {
        let cmp = Qt.createComponent("../types/SimpleNotification.qml");
        let not = {
            summary,
            body,
            appName,
            urgency,
            date: new Date()
        };
        let obj = cmp.createObject(root, not);
        return obj;
    }

    function push(summary: string, body: string, appName: string, urgency: int): void {
        let obj = root._createSimpleNotification(summary, body, appName, urgency);
        root._isEphemeral = Config.notification.ephemeral.includes(appName);
        if (root._isEphemeral)
            root._current = obj;

        root.notifications.push(obj);
    }

    function remove(date: date): void {
        root.notifications = Array.from(root.notifications).filter(c => c.date.getTime() != date.getTime());
    }

    function clear(): void {
        root.notifications = [];
    }

    FileView {
        id: fileView
        path: Qt.resolvedUrl(Quickshell.dataDir + "/history.json")

        function update(): bool {
            let filtered = root.notifications.filter(c => !root.ephemeral.includes(c));
            fileView.setText(JSON.stringify(filtered, (key, value) => {
                if (key === "objectName")
                    return undefined;

                return value;
            }, 2));
        }

        printErrors: !Config.notification.history
        onLoadFailed: error => {
            if (!Config.notification.history)
                return;

            if (error == FileViewError.FileNotFound) {
                fileView.update();
                root._loaded = true;
                return;
            }
        }

        onLoaded: {
            if (!Config.notification.history)
                return;

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
