pragma ComponentBehavior: Bound

import Quickshell

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.settings
import qs.utils
import qs.widgets
import qs.helpers

LazyLoader {
    active: Config.calendar.enabled && States.showCalendar

    PanelWindow {
        screen: Quickshell.screens[0]
        anchors {
            top: true
            left: true
        }

        margins {
            top: Appearance.margin.normal
            left: Appearance.margin.normal
        }

        implicitWidth: Config.calendar.dynamicSize ? screen.width / 4 : Config.calendar.width
        implicitHeight: Config.calendar.dynamicSize ? screen.height / 3 : Config.calendar.height
        color: Colors.backgroundc

        ColumnLayout {
            anchors.fill: parent
            anchors {
                topMargin: Appearance.spacing.normal
                bottomMargin: Appearance.spacing.normal
            }
            spacing: Appearance.spacing.normal

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: Appearance.margin.normal
                Layout.rightMargin: Layout.leftMargin
                Layout.preferredHeight: Appearance.font.normal + Appearance.padding.normal * 2

                spacing: Appearance.margin.normal

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.horizontalStretchFactor: 1

                    Text {
                        property bool hovered: false

                        anchors.centerIn: parent
                        height: parent.height
                        width: height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: Appearance.font.icon
                        text: "<"

                        Rectangle {
                            anchors.fill: parent
                            opacity: parent.hovered ? 0.25 : 0
                            radius: Appearance.radius.small
                            color: Colors.background
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true

                            onEntered: {
                                parent.hovered = true;
                            }
                            onExited: {
                                parent.hovered = false;
                            }
                            onClicked: {
                                monthGrid.previous();
                            }
                        }
                    }
                }

                Text {
                    Layout.preferredWidth: parent.width / 3
                    Layout.fillHeight: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: monthGrid.title
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.horizontalStretchFactor: 1

                    Text {
                        property bool hovered: false

                        anchors.centerIn: parent
                        height: parent.height
                        width: height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: Appearance.font.icon
                        text: ">"

                        Rectangle {
                            anchors.fill: parent
                            opacity: parent.hovered ? 0.25 : 0
                            radius: Appearance.radius.small
                            color: Colors.background
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true

                            onEntered: {
                                parent.hovered = true;
                            }
                            onExited: {
                                parent.hovered = false;
                            }
                            onClicked: {
                                monthGrid.next();
                            }
                        }
                    }
                }
            }

            DayOfWeekRow {
                Layout.fillWidth: true
                Layout.preferredHeight: Appearance.font.normal + Appearance.padding.normal * 2
                spacing: Appearance.spacing.large
                locale: monthGrid.locale

                delegate: Text {
                    required property string narrowName
                    horizontalAlignment: Text.AlignHCenter
                    text: narrowName
                }
            }

            MonthGrid {
                id: monthGrid
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: Appearance.spacing.large

                month: parseInt(Qt.formatDateTime(Time.date, "M")) - 1
                year: parseInt(Qt.formatDateTime(Time.date, "yyyy"))
                locale: Qt.locale(Config.locale)

                function next(): void {
                    let nextMonth = monthGrid.month + 1;
                    if (nextMonth > 11) {
                        monthGrid.year = monthGrid.year + 1;
                        nextMonth = 0;
                    }

                    monthGrid.month = nextMonth;
                }

                function previous(): void {
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
                        anchors.centerIn: parent
                        implicitWidth: implicitHeight
                        implicitHeight: parent.height
                        opacity: parent.model.today ? 0.5 : 0.25
                        radius: Appearance.radius.normal
                        color: parent.model.today ? Colors.aqua : Colors.gray
                    }
                }
            }
        }
    }
}
