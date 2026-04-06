pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components
import qs.config

Item {
    id: root
    property int icon: -1
    property bool enabled: true
    property color color: Colors.foreground
    property bool hoverEnabled: false
    readonly property bool react: color == Colors.foreground || color == Colors.foregroundMuted
    property BackgroundProperties background: BackgroundProperties {}
    property string text: ""

    component BackgroundProperties: QtObject {
        property bool hover: false
        property bool visible: false
        property color color: Colors.foregroundMuted
        property real opacity: 0.25
        property real radius: Appearance.radius.small
    }

    signal clicked(MouseEvent mouse)
    signal wheel(WheelEvent wheel)
    signal entered
    signal exited

    implicitWidth: row.implicitWidth + (text != "" ? height * 0.3 : 0)

    Rectangle {
        id: backgroundItem
        anchors.fill: parent
        visible: root.background.visible
        radius: root.background.radius
        color: root.background.color
        opacity: root.background.opacity
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
                implicitSize: height * 0.7
                color: root.enabled ? root.color : Colors.disabled
                icon: root.icon
            }
        }

        Loader {
            Layout.fillHeight: true
            Layout.fillWidth: true

            active: root.text != ""
            sourceComponent: Text {
                id: textItem
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: root.text
            }
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
                root.color = Colors.foregroundMuted;
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
