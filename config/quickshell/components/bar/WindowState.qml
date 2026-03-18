import Quickshell.Wayland

import qs.components

Text {
    text: ToplevelManager.activeToplevel?.maximized ? "Zoom" : "Normal"
}
