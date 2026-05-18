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
            duration: 400
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

            function d2r(angle: int): real {
                return angle * Math.PI / 180;
            }

            let centerX = this.width / 2;
            let centerY = this.height / 2;
            let radius = (this.width / 2) - 8;
            let start = d2r(135);
            let end = d2r(45);

            ctx.lineWidth = 6;
            ctx.lineCap = "round";

            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, start, end, false);
            ctx.strokeStyle = Colors.container;
            ctx.stroke();

            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, start, start + d2r(270 * root.percentage), false);
            ctx.strokeStyle = Colors.foreground;
            ctx.stroke();
        }
    }

    Text {
        text: Math.round(root.percentage * 100)
        x: parent.width / 2 - this.width / 2
        y: parent.height - this.height
    }
}
