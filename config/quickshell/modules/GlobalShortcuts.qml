import QtQuick
import Quickshell

import qs.components
import qs.config
import qs.modules
import qs.services
import qs.utils
import qs.modules

Scope {
    Shortcut {
        name: "closePopups"
        description: "Close all current opened popups"
        onPressed: {
            if (!ModulesState.isPopupOpen)
                return;
            ModulesState.closeAll();
        }
    }

    Shortcut {
        name: "toggleMpris"
        description: "Toggle mpris state"
        onPressed: {
            if (!Config.modules.mpris || ModulesState.currentTopLevelFullscreen)
                return;
            ModulesState.toggleMpris();
        }
    }

    Shortcut {
        name: "areaScreenshot"
        description: "Open an area picker to take a screenshot using grim"
        onPressed: {
            ModulesState.toggleAreaPicker(AreaPicker.Screenshot);
        }
    }

    Shortcut {
        name: "fullScreenshot"
        description: "Take a screenshot of the fullscreen"
        onPressed: {
            States.updateCurrentScreen();
            let currentScreen = ModulesState.currentScreen;
            ScreenshotManager.capture(Qt.rect(0, 0, currentScreen.width, currentScreen.height));
        }
    }
}
