pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Item {
    id: root
    property int icon: -1
    property color color: Colors.foreground
    property color _defaultColor
    property bool _horeved: false
    property bool hoverEnabled: false

    property BackgroundProperties background: BackgroundProperties {}
    property BorderProperties border: BorderProperties {}

    final property alias enabled: area.enabled
    property alias text: textItem.text
    property alias font: textItem.font

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

    implicitWidth: contentRow.implicitWidth

    // Background
    Rectangle {
        anchors.fill: parent
        opacity: (root.background.visible || root._horeved) ? root.background.opacity : 0
        color: root.background.color
        radius: root.background.radius
    }

    // Border
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        opacity: root.border.opacity

        border {
            color: root.border.color
            width: root.border.width
            pixelAligned: root.border.pixelAligned
        }
    }

    // Content
    RowLayout {
        id: contentRow
        anchors.fill: parent

        Icon {
            id: iconItem
            visible: root.icon >= 0
            Layout.fillHeight: true
            Layout.preferredWidth: height
            icon: root.icon
            color: !root.enabled ? Colors.containerMute : root.color
        }

        Text {
            id: textItem
            visible: !!root.text
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: !root.enabled ? Colors.containerMute : root.color
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Item {
            visible: textItem.visible && iconItem.visible
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        cursorShape: !enabled ? Qt.ForbiddenCursor : Qt.PointingHandCursor
        hoverEnabled: root.hoverEnabled || root.background.hover

        onClicked: e => root.clicked(e)
        onWheel: e => root.wheel(e)
        onEntered: {
            if (root.hoverEnabled) {
                root._defaultColor = root.color;
                root.color = Qt.hsla(root._defaultColor.hslHue, root._defaultColor.hslSaturation * 0.1, root._defaultColor.hslLightness - 0.2, 1);
            }

            if (root.background.hover)
                root._horeved = true;

            root.entered();
        }
        onExited: {
            if (root.hoverEnabled)
                root.color = root._defaultColor;

            if (root.background.hover)
                root._horeved = false;

            root.exited();
        }
    }
}
