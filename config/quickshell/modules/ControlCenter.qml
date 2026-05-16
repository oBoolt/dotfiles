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

    implicitWidth: parent.width * 0.25
    implicitHeight: parent.height * 0.6

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

                popEnter: Transition {}
                popExit: Transition {}
                pushEnter: Transition {}
                pushExit: Transition {}
            }
        }
    }

    Component {
        id: mainPage
        MainPage {
            stackView: loader.stackView
            onPush: page => {
                if (page == Page.Audio) {
                    loader.stackView.push(audioPage);
                    return;
                }
                if (page == Page.SystemInfo) {
                    loader.stackView.push(systemInfoPage);
                    return;
                }
                if (page == Page.Bluetooth) {
                    loader.stackView.push(bluetoothPage);
                    return;
                }
            }
        }
    }
    Component {
        id: audioPage
        AudioPage {
            stackView: loader.stackView
            onPop: loader.stackView.pop()
        }
    }
    Component {
        id: systemInfoPage
        SystemInfoPage {
            stackView: loader.stackView
            onPop: loader.stackView.pop()
        }
    }
    Component {
        id: bluetoothPage
        BluetoothPage {
            stackView: loader.stackView
            onPop: loader.stackView.pop()
        }
    }
}
