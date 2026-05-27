import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import qs.config
import qs.utils
import qs.components

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

            RowLayout {
                spacing: 4
                implicitHeight: 16
                implicitWidth: (height * 2) + spacing
                y: root.screen.height - implicitHeight - spacing
                x: root.screen.width - implicitWidth - spacing

                Button {
                    Layout.preferredWidth: parent.height
                    Layout.preferredHeight: parent.height
                    background.hover: true
                    icon: Icons.GoPreviousSymbolic
                    onClicked: Config.setWallpaper(Config.wallpaperIndex - 1)
                }
                Button {
                    Layout.preferredWidth: parent.height
                    Layout.preferredHeight: parent.height
                    background.hover: true
                    icon: Icons.GoNextSymbolic
                    onClicked: Config.setWallpaper(Config.wallpaperIndex + 1)
                }
            }
        }
    }
}
