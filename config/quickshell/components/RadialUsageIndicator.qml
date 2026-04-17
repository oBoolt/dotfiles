import QtQuick

import qs.config

Item {
    id: root
    property alias icon: iconItem.icon
    property real percentage: 0

    onPercentageChanged: canvas.requestPaint()

    Behavior on percentage {
        enabled: Appearance.animations.enabled
        NumberAnimation {
            duration: 500
        }
    }

    Icon {
        id: iconItem
        anchors.centerIn: parent
        implicitWidth: parent.width / 2
        implicitHeight: width
        icon: 0
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            let ctx = getContext("2d");
            ctx.reset();

            let centerX = this.width / 2;
            let centerY = this.height / 2;
            let radius = 14;
            let angle = Math.PI * 2 * root.percentage;

            ctx.lineWidth = 4;
            ctx.lineCap = "round";

            ctx.beginPath();
            ctx.strokeStyle = Colors.backgroundMuted;
            ctx.arc(centerX, centerY, radius, 0, Math.PI * 2, false);
            ctx.stroke();

            ctx.beginPath();
            ctx.strokeStyle = Colors.foreground;
            ctx.arc(centerX, centerY, radius, 0, -angle, true);
            ctx.stroke();
        }
    }
}
