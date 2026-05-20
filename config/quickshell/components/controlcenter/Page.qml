import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.components
import qs.config
import qs.utils

Item {
    id: root
    default property alias innerData: inner.data
    required property StackView stackView
    property string title: ""
    property Item rightArea

    enum Enum {
        Main,
        Audio,
        SystemInfo,
        Bluetooth,
        Network
    }

    signal pop
    signal push(int page)

    ColumnLayout {
        id: inner

        RowLayout {
            visible: root.stackView.depth > 1
            Layout.fillWidth: true

            Button {
                Layout.preferredHeight: Appearance.font.icon
                hoverEnabled: true
                background.hover: true
                text: "Back"
                icon: Icons.GoPreviousSymbolic
                onClicked: root.stackView.pop()
            }
            Item {
                Layout.fillWidth: true
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                visible: root.title != ""
                text: root.title
                font.pixelSize: Appearance.font.large
            }

            Item {
                Layout.fillWidth: true
            }

            Component.onCompleted: this.children.push(root.rightArea)
        }

        anchors.fill: parent
        anchors.margins: Appearance.margin.large
        spacing: Appearance.spacing.large
    }
}
