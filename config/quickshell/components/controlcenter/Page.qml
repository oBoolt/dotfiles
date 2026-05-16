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

    enum Enum {
        Main,
        Audio,
        SystemInfo,
        Bluetooth
    }

    signal pop
    signal push(int page)

    ColumnLayout {
        id: inner

        Button {
            Layout.preferredHeight: Appearance.font.icon
            visible: root.stackView.depth > 1
            hoverEnabled: true
            background.hover: true
            text: "Back"
            icon: Icons.GoPreviousSymbolic
            onClicked: root.stackView.pop()
        }

        anchors.fill: parent
        anchors.margins: Appearance.margin.large
        spacing: Appearance.spacing.large
    }
}
