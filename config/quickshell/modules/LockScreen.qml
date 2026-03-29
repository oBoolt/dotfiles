pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam

import qs.utils
import qs.components
import qs.config

WlSessionLock {
    id: lock
    locked: States.sessionLocked
    property string status: "..."

    WlSessionLockSurface {
        PamContext {
            id: pam
            property string password: ""

            function login(password: string): void {
                if (pam.active)
                    pam.abort();
                pam.password = password;
                pam.start();
            }

            onResponseRequiredChanged: {
                if (pam.responseRequired && !!pam.password) {
                    pam.respond(pam.password);
                    pam.password = "";
                }
            }
            onCompleted: result => {
                if (result == PamResult.Success) {
                    States.sessionLocked = false;
                }
                lock.status = PamResult.toString(result);
            }
        }
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
                            pam.login(this.text);
                            this.clear();
                        }
                    }
                }
            }
        }
    }
}
