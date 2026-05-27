import QtQuick
import Qt.labs.folderlistmodel

import Quickshell
import Quickshell.Wayland

import qs.config
import qs.utils

LazyLoader {
    active: Config.modules.background && (Quickshell.screens.length > 0)

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property ShellScreen modelData
            property list<string> wallpapers: []

            screen: modelData
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            anchors {
                top: true
                bottom: true
                left: true
                right: true
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

                        Config.wallpapersSize = root.wallpapers.length;
                    }
                }
            }

            Image {
                id: backgroundItem
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: root.wallpapers.length > 0 ? Qt.resolvedUrl(root.wallpapers[(Config.wallpaperIndex % root.wallpapers.length)]) : ""
            }
        }
    }
}
