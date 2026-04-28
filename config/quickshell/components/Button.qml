pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Item {
    id: root
    property int icon: -1
    final property bool enabled: true
    property color color: Colors.foreground
    property bool hoverEnabled: false
    readonly property bool react: color == Colors.foreground || color == Colors.foregroundMute
    property BackgroundProperties background: BackgroundProperties {}
    property alias text: textItem.text
    property alias font: textItem.font
    readonly property bool hasText: text != ""
    property BorderProperties border: BorderProperties {}

    component BackgroundProperties: QtObject {
        property bool hover: false
        property bool visible: false
        property color color: Colors.foregroundMute
        property real opacity: 0.25
        property real radius: Appearance.radius.small
    }

    component BorderProperties: QtObject {
        property color color: Colors.main
        property int width: 0
        property bool pixelAligned: true
        property real opacity: 1
    }

    signal clicked(MouseEvent mouse)
    signal wheel(WheelEvent wheel)
    signal entered
    signal exited

    implicitWidth: row.implicitWidth + (hasText ? height * 0.3 : 0)
    implicitHeight: hasText ? row.implicitHeight : 0

    Rectangle {
        id: backgroundItem
        anchors.fill: parent
        visible: root.background.visible
        radius: root.background.radius
        color: root.background.color
        opacity: root.background.opacity
    }

    Rectangle {
        visible: root.border.width > 0
        anchors.fill: parent
        opacity: root.border.opacity
        radius: root.background.radius
        color: "transparent"

        border {
            width: root.border.width
            pixelAligned: root.border.pixelAligned
            color: root.border.color
        }
    }

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: 0

        Loader {
            active: root.icon >= 0
            Layout.fillHeight: active
            Layout.preferredWidth: height

            sourceComponent: Icon {
                anchors.fill: parent
                color: root.enabled ? root.color : Colors.container
                icon: root.icon
            }
        }

        Text {
            id: textItem
            Layout.fillHeight: true
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: root.color
        }
    }

    MouseArea {
        id: area
        enabled: root.enabled
        hoverEnabled: root.hoverEnabled || root.background.hover
        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
        onClicked: e => root.clicked(e)
        onEntered: {
            root.entered();
            if (root.background.hover)
                root.background.visible = true;
            if (root.react && root.hoverEnabled && !root.background.hover)
                root.color = Colors.foregroundMute;
        }
        onExited: {
            root.exited();
            if (root.background.hover)
                root.background.visible = false;
            if (root.react && root.hoverEnabled && !root.background.hover)
                root.color = Colors.foreground;
        }
        onWheel: e => root.wheel(e)
    }
}
