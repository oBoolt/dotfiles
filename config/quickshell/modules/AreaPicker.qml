import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.utils
import qs.config
import qs.services

LazyLoader {
    active: Config.modules.areapicker && States.showAreaPicker

    enum Enum {
        Screenshot
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property ShellScreen modelData
            property rect area

            property bool _first: true
            property point _firstPoint
            property point _currentPoint

            readonly property real _opacity: 0.25
            readonly property color _color: "white"

            screen: modelData
            color: "transparent"

            exclusionMode: ExclusionMode.Ignore
            implicitHeight: modelData.height
            implicitWidth: modelData.width
            WlrLayershell.layer: WlrLayer.Overlay

            onAreaChanged: {
                if (States.areaPickerMode === AreaPicker.Screenshot) {
                    ScreenshotManager.capture(area);
                }

                States.showAreaPicker = false;
            }

            // Background
            Rectangle {
                visible: root._firstPoint === Qt.point(0, 0)
                anchors.fill: parent
                color: root._color
                opacity: root._opacity
            }

            // White Area
            Item {
                visible: root._firstPoint !== Qt.point(0, 0)
                Rectangle {
                    x: 0
                    y: 0
                    width: selector.x
                    height: root.height
                    opacity: root._opacity
                    color: root._color
                }
                Rectangle {
                    x: selector.x + selector.width
                    y: 0
                    width: root.width - x
                    height: root.height
                    opacity: root._opacity
                    color: root._color
                }
                Rectangle {
                    x: selector.x
                    y: 0
                    width: selector.width
                    height: selector.y
                    opacity: root._opacity
                    color: root._color
                }
                Rectangle {
                    x: selector.x
                    y: selector.y + selector.height
                    width: selector.width
                    height: root.height - selector.height
                    opacity: root._opacity
                    color: root._color
                }
            }

            // Area selector
            Rectangle {
                id: selector
                color: "transparent"
            }

            // Border
            Rectangle {
                visible: selector.width > 0 && selector.height > 0
                implicitWidth: selector.width + border.width * 2
                implicitHeight: selector.height + border.width * 2
                x: selector.x - border.width
                y: selector.y - border.width
                color: "transparent"
                border.width: 2
                border.color: Colors.danger
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.CrossCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onPositionChanged: e => {
                    root._currentPoint = Qt.point(e.x, e.y);

                    if (root._first) {
                        root._firstPoint = Qt.point(e.x, e.y);
                        root._first = false;
                    }

                    selector.x = (e.x - root._firstPoint.x < 0) ? e.x : root._firstPoint.x;
                    selector.y = (e.y - root._firstPoint.y < 0) ? e.y : root._firstPoint.y;

                    selector.width = (e.x - selector.x > 0) ? (e.x - root._firstPoint.x) : (root._firstPoint.x - e.x);
                    selector.height = (e.y - selector.y > 0) ? (e.y - root._firstPoint.y) : (root._firstPoint.y - e.y);
                }
                onReleased: e => {
                    if (e.button === Qt.RightButton) {
                        root._firstPoint = Qt.point(0, 0);

                        selector.x = 0;
                        selector.y = 0;
                        selector.width = 0;
                        selector.height = 0;

                        root._first = true;
                        return;
                    }

                    root.area = Qt.rect(selector.x, selector.y, selector.width, selector.height);
                }
            }
        }
    }
}
