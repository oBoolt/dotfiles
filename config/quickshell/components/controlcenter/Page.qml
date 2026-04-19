import QtQuick
import QtQuick.Layouts

import qs.config

Item {
    default property alias data: inner.data

    enum Enum {
        Main,
        Audio,
        SystemInfo
    }

    signal pop
    signal push(int page)

    ColumnLayout {
        id: inner
        anchors.fill: parent
        anchors.margins: Appearance.margin.large
        spacing: Appearance.spacing.large
    }
}
