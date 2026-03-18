import QtQuick
import Quickshell.Hyprland

import qs.components

Text {
    text: Hyprland.activeToplevel?.title ?? ""
    elide: Text.ElideRight
    maximumLineCount: 1
}
