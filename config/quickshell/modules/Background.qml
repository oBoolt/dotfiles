import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import qs.config
import qs.utils
import qs.components
import qs.services

LazyLoader {
    active: Config.modules.background && (Quickshell.screens.length > 0)

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property ShellScreen modelData

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
                id: backgroundItem
                visible: source !== ""
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: Wallpaper.get()
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
                    onClicked: Wallpaper.next()
                }
                Button {
                    Layout.preferredWidth: parent.height
                    Layout.preferredHeight: parent.height
                    background.hover: true
                    icon: 0
                    onClicked: Wallpaper.setRandom()
                }
                Button {
                    Layout.preferredWidth: parent.height
                    Layout.preferredHeight: parent.height
                    background.hover: true
                    icon: Icons.GoNextSymbolic
                    onClicked: Wallpaper.previous()
                }
            }
        }
    }
}
