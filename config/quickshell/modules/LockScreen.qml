pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import qs.utils
import qs.config
import qs.services

WlSessionLock {
    id: lock
    locked: States.sessionLocked

    WlSessionLockSurface {
        Image {
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Qt.resolvedUrl(Quickshell.env("XDG_CONFIG_HOME") + "/wallpapers/hk-4-3840_2160.jpg")
        }
        Rectangle {
            anchors.fill: parent
            color: Colors.background
            opacity: 0.5
        }
        Rectangle {
            anchors.centerIn: parent
            implicitWidth: (parent.width / 3)
            implicitHeight: (parent.height / 3)
            color: Colors.backgroundMuted
            radius: Appearance.radius.large
            ColumnLayout {
                Rectangle {
                    implicitHeight: 20
                    implicitWidth: 100
                    TextInput {
                        anchors.fill: parent
                        focus: true
                        echoMode: TextInput.Password
                        passwordCharacter: "*"
                        onAccepted: {
                            // pam.login(this.text);
                            Pam.login(this.text);
                            this.clear();
                        }
                    }
                }
            }
        }
    }
}
