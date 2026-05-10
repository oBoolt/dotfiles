import QtQuick
import Quickshell

import qs.components
import qs.config
import qs.utils
import qs.modules
import qs.services

Scope {
    Shortcut {
        name: "closePopups"
        description: "Close all current opened popups"
        onPressed: {
            if (!States.isPopupOpen)
                return;
            States.closeAll();
        }
    }

    Shortcut {
        name: "toggleMpris"
        description: "Toggle mpris state"
        onPressed: {
            if (!Config.modules.mpris || States.currentTopLevelFullscreen)
                return;
            States.toggleMpris();
        }
    }

    Shortcut {
        name: "areaScreenshot"
        description: "Open an area picker to take a screenshot using grim"
        onPressed: {
            States.toggleAreaPicker(AreaPicker.Screenshot);
        }
    }

    Shortcut {
        name: "fullScreenshot"
        description: "Take a screenshot of the fullscreen"
        onPressed: {
            States.updateCurrentScreen();
            let currentScreen = States.currentScreen;
            ScreenshotManager.capture(Qt.rect(0, 0, currentScreen.width, currentScreen.height));
        }
    }
}
