import QtQuick

import qs.config
import qs.components

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
        x: parent.width / 2 - this.width / 2
        y: parent.height / 2 - (this.height / 2) - 2
        implicitWidth: (parent.width / 2)
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
            let radius = (this.width / 2) - 8;

            ctx.lineWidth = 6;
            ctx.lineCap = "round";

            let start = (Math.PI / 6);
            let end = (Math.PI / 2) + start * 2;
            let angle = end * root.percentage;

            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, start, end, true);
            ctx.strokeStyle = Colors.container;
            ctx.stroke();

            ctx.beginPath();
            ctx.strokeStyle = Colors.foreground;
            ctx.arc(centerX, centerY, radius, start, -angle, true);
            ctx.stroke();
        }
    }

    Text {
        text: Math.round(root.percentage * 100)
        x: parent.width / 2 - this.width / 2
        y: parent.height - this.height
    }
}
