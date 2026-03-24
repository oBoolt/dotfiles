import Quickshell.Io
import QtQuick

JsonObject {
    property Commands commands: Commands {}

    component Commands: JsonObject {
        property string poweroff: "systemctl poweroff"
        property string reboot: "systemctl reboot"
    }
}
