import Quickshell

import QtQuick
import QtQuick.Layouts

import qs.settings
import qs.utils
import qs.widgets

LazyLoader {
    active: States.showControlCenter

    PanelWindow {
        anchors {
            top: true
            right: true
        }

        margins {
            top: 8
            right: 8
        }

        implicitWidth: 400
        implicitHeight: 600

        ColumnLayout {
            anchors.fill: parent

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 8
                Layout.rightMargin: 8

                Text {
                    Layout.fillWidth: true
                    text: "<"
                    font.pixelSize: 30
                    color: "black"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            pageManager.previous();
                        }
                    }
                }
                Text {
                    Layout.fillWidth: true
                    text: ">"
                    font.pixelSize: 30
                    color: "black"
                    horizontalAlignment: Text.AlignRight

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            pageManager.next();
                        }
                    }
                }
            }

            PageManager {
                id: pageManager
                Layout.fillWidth: true
                Layout.fillHeight: true
                active: true

                Component {
                    Page {
                        Rectangle {
                            anchors.fill: parent
                            color: "blue"
                        }
                    }
                }
                Component {
                    Page {
                        Rectangle {
                            anchors.fill: parent
                            color: "yellow"
                        }
                    }
                }
                Component {
                    Page {
                        Rectangle {
                            anchors.fill: parent
                            color: "red"
                        }
                    }
                }
            }
        }
    }
}
