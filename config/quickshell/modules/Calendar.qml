pragma ComponentBehavior: Bound

import Quickshell

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.components
import qs.utils

Item {
    id: root
    anchors {
        top: parent.top
        left: parent.left

        topMargin: Appearance.margin.normal + States.barZone
        leftMargin: Appearance.margin.normal
    }

    // implicitWidth: 400 * Config.scaleFactor[screen.name]
    // implicitHeight: 350 * Config.scaleFactor[screen.name]
    implicitWidth: 400
    implicitHeight: 350

    Loader {
        active: Config.modules.calendar && States.showCalendar
        anchors.fill: parent

        sourceComponent: Rectangle {
            anchors.fill: parent
            color: Colors.background
            radius: Appearance.radius.small

            ColumnLayout {
                anchors.margins: Appearance.margin.large
                anchors.fill: parent

                RowLayout {
                    Layout.fillWidth: true

                    Item {
                        Layout.preferredHeight: Appearance.font.icon
                        Layout.preferredWidth: parent.width / 4

                        Button {
                            implicitHeight: parent.height
                            anchors.centerIn: parent
                            hoverEnabled: true
                            onClicked: monthGrid.previousMonth()
                            icon: Icons.GoPreviousSymbolic
                        }
                    }
                    Text {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: Appearance.font.large
                        text: monthGrid.title
                    }
                    Item {
                        Layout.preferredHeight: Appearance.font.icon
                        Layout.preferredWidth: parent.width / 4

                        Button {
                            implicitHeight: parent.height
                            anchors.centerIn: parent
                            hoverEnabled: true
                            onClicked: monthGrid.nextMonth()
                            icon: Icons.GoNextSymbolic
                        }
                    }
                }

                DayOfWeekRow {
                    Layout.fillWidth: true
                    locale: monthGrid.locale

                    delegate: Text {
                        required property string shortName

                        text: shortName
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                MonthGrid {
                    id: monthGrid
                    function nextMonth(): void {
                        if (((monthGrid.month + 1) % 12) == 0)
                            monthGrid.year++;
                        monthGrid.month = (monthGrid.month + 1) % 12;
                    }

                    function previousMonth(): void {
                        if ((monthGrid.month - 1) < 0)
                            monthGrid.year--;
                        monthGrid.month = (monthGrid.month - 1) < 0 ? 11 : monthGrid.month - 1;
                    }

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: Appearance.spacing.small
                    month: parseInt(Qt.formatDateTime(Time.date, "M")) - 1
                    year: parseInt(Qt.formatDateTime(Time.date, "yyyy"))
                    locale: Qt.locale(Config.locale)

                    delegate: Text {
                        required property var model

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: model.month === monthGrid.month ? 1 : 0.5
                        text: monthGrid.locale.toString(model.date, "d")
                        font: monthGrid.font

                        Rectangle {
                            property bool hovered: false
                            readonly property bool today: parent.model.today

                            implicitHeight: parent.height
                            implicitWidth: height
                            anchors.centerIn: parent
                            radius: Appearance.radius.normal
                            opacity: hovered ? 0.5 : today ? 0.25 : 0
                            color: today ? Colors.main : Colors.foregroundMuted

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor

                                onEntered: parent.hovered = true
                                onExited: parent.hovered = false
                                //TODO: copy month to clipboard
                                onClicked: console.log(Qt.formatDateTime(model.date, "dd/MMM/yyyy"))
                            }
                        }
                    }
                }
            }
        }
    }
}
