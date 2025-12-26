import QtQuick
import Quickshell.Hyprland

import qs.widgets.common

Text {
    text: Hyprland.activeToplevel?.title ?? ""
    elide: Text.ElideRight
    maximumLineCount: 1
}
