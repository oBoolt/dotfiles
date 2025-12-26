import Quickshell.Wayland

import qs.widgets.common

Text {
    text: ToplevelManager.activeToplevel?.maximized ? "Zoom" : "Normal"
}
