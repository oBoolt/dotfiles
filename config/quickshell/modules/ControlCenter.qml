pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.utils
import qs.components
import qs.components.controlcenter
import qs.services
import qs.config

Item {
    id: root
    anchors {
        top: parent.top
        right: parent.right

        topMargin: Appearance.margin.normal + States.barZone
        rightMargin: Appearance.margin.normal
    }

    // implicitWidth: 480 * Config.scaleFactor[screen.name]
    implicitWidth: 480
    implicitHeight: parent.height * 0.75

    Loader {
        id: loader
        active: Config.modules.controlcenter && States.showControlCenter
        anchors.fill: parent

        property StackView stackView

        sourceComponent: Rectangle {
            anchors.fill: parent
            color: Colors.background
            radius: Appearance.radius.small
            clip: true

            StackView {
                id: stackView
                anchors.fill: parent
                initialItem: mainPage
                Component.onCompleted: loader.stackView = this
            }
        }
    }

    Component {
        id: mainPage
        MainPage {
            onPush: page => {
                if (page == Page.Audio) {
                    loader.stackView.push(audioPage);
                    return;
                }
                if (page == Page.SystemInfo) {
                    loader.stackView.push(systemInfoPage);
                    return;
                }
            }
        }
    }
    Component {
        id: audioPage
        AudioPage {}
    }
    Component {
        id: systemInfoPage
        SystemInfoPage {}
    }
}
