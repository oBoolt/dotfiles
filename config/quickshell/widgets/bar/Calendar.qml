import Quickshell

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.settings
import qs.widgets.common
import qs.helpers

PopupWindow {
    id: root
    anchor.adjustment: PopupAdjustment.None
    implicitWidth: 350
    // do this way for Calendar hover exit event
    implicitHeight: 250 + Variables.barSize
    anchor.rect.x: 0
    anchor.rect.y: 0
    visible: false
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: () => {
            root.visible = false;
        }
        onEntered: () => {
            monthGrid.month = parseInt(Qt.formatDateTime(Time.date, "M")) - 1;
            monthGrid.year = parseInt(Qt.formatDateTime(Time.date, "yyyy"));
        }
        onExited: () => {
            root.visible = false;
        }
        Rectangle {
            color: root.anchor.window.color
            implicitHeight: root.implicitHeight - Variables.barSize
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            bottomRightRadius: Variables.calendarRadius

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    Layout.leftMargin: Variables.calendarPadding
                    Layout.rightMargin: Layout.leftMargin

                    Rectangle {
                        property bool hovered: false
                        Layout.preferredWidth: Variables.fontSize * 2
                        Layout.preferredHeight: Layout.preferredWidth
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true

                            onEntered: () => {
                                parent.hovered = true;
                            }

                            onExited: () => {
                                parent.hovered = false;
                            }

                            onClicked: () => {
                                monthGrid.previousMonth();
                            }
                        }

                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: parent.hovered ? Colors.gray : Colors.foreground
                            text: "<"
                        }
                    }
                    Text {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: monthGrid.title
                    }

                    Rectangle {
                        property bool hovered: false
                        Layout.preferredWidth: Variables.fontSize * 2
                        Layout.preferredHeight: Layout.preferredWidth
                        color: "transparent"

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true

                            onEntered: () => {
                                parent.hovered = true;
                            }

                            onExited: () => {
                                parent.hovered = false;
                            }

                            onClicked: () => {
                                monthGrid.nextMonth();
                            }
                        }

                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: parent.hovered ? Colors.gray : Colors.foreground
                            text: ">"
                        }
                    }
                }

                DayOfWeekRow {
                    Layout.fillWidth: true
                    delegate: Text {
                        required property string narrowName
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: narrowName
                    }
                }

                MonthGrid {
                    id: monthGrid
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: Variables.barPadding

                    month: parseInt(Qt.formatDateTime(Time.date, "M")) - 1
                    year: parseInt(Qt.formatDateTime(Time.date, "yyyy"))
                    locale: Qt.locale("en_US")

                    function nextMonth(): void {
                        let nextMonth = monthGrid.month + 1;
                        if (nextMonth > 11) {
                            monthGrid.year = monthGrid.year + 1;
                            nextMonth = 0;
                        }

                        monthGrid.month = nextMonth;
                    }

                    function previousMonth(): void {
                        let previousMonth = monthGrid.month - 1;
                        if (previousMonth < 0) {
                            monthGrid.year = monthGrid.year - 1;
                            previousMonth = 11;
                        }

                        monthGrid.month = previousMonth;
                    }

                    delegate: Text {
                        required property var model
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: model.month == monthGrid.month ? 1 : 0.25
                        text: model.day

                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            implicitWidth: height + 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parent.model.today ? Colors.aqua : Colors.gray
                            radius: Variables.barRadius
                            opacity: parent.model.today ? 0.5 : 0.25
                        }
                    }
                }
            }
        }
    }
}
