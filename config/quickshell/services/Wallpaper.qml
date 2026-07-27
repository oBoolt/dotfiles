pragma Singleton

import QtQuick
import Qt.labs.folderlistmodel

import Quickshell

import qs.config

Singleton {
    id: root

    property list<string> wallpapers: []

    property bool ready: false

    readonly property string random: {
        if (Config.wallpaperIndex < 0 && root.ready) {
            return root.wallpapers[Math.floor(Math.random() * root.wallpapers.length) - 1];
        }
        return "";
    }

    function set(index: int): void {
        if (index == -99) {
            Config.wallpaperIndex = index;
            Config.file.writeAdapter();
            return;
        }

        Config.wallpaperIndex = index < 0 ? (root.wallpapers.length - 1) : (index % root.wallpapers.length);
        Config.file.writeAdapter();
    }

    function get(): string {
        if (!root.ready) {
            return "";
        }

        if (Config.wallpaperIndex < 0) {
            return Qt.resolvedUrl(root.random);
        }

        return Qt.resolvedUrl(root.wallpapers[Config.wallpaperIndex]);
    }

    function next(): void {
        root.set(Config.wallpaperIndex + 1);
    }

    function previous(): void {
        root.set(Config.wallpaperIndex + 1);
    }

    function setRandom(): void {
        root.set(-99);
    }

    FolderListModel {
        id: folderModel
        folder: Qt.resolvedUrl(Quickshell.env("XDG_CONFIG_HOME") + "/wallpapers/")
        nameFilters: ["*.png", "*.jpg", "*.jpeg"]
        showDirs: false
        onStatusChanged: {
            if (folderModel.status == FolderListModel.Ready) {
                for (let i = 0; i < folderModel.count; i++) {
                    let path = folderModel.get(i, "filePath");
                    let name = folderModel.get(i, "fileBaseName");

                    if (name == "default")
                        continue;

                    root.wallpapers.push(path);
                }
                root.ready = true;
            }
        }
    }
}
