import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.components
import qs.config
import qs.utils
import qs.services

RowLayout {
    id: root

    property alias value: slider.value
    property alias from: slider.from
    property alias icon: iconItem.icon
    final property bool enabled: true
    signal moved

    spacing: Appearance.spacing.normal

    Icon {
        id: iconItem
        Layout.fillHeight: true
        Layout.preferredWidth: height
        Layout.margins: 4
        implicitSize: height * 0.75
    }

    Slider {
        id: slider
        Layout.fillWidth: true
        Layout.fillHeight: true

        from: 0
        to: root.enabled ? 1 : 0
        stepSize: 0.01
        handle: Item {}
        background: Rectangle {
            color: Colors.container

            Rectangle {
                color: Colors.main
                implicitWidth: slider.visualPosition * parent.width
                implicitHeight: parent.height
            }
        }

        onMoved: {
            if (!root.enabled)
                return;
            root.moved();
        }
    }
}
