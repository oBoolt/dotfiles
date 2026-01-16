import Quickshell.Wayland

import qs.widgets

Text {
    text: ToplevelManager.activeToplevel?.maximized ? "Zoom" : "Normal"
}
