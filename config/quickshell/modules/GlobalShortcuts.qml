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
        name: "global:closePopups"
        description: "Close all current opened popups"
        onPressed: {
            if (!ModulesState.isModuleOpen)
                return;
            ModulesState.closeAll();
        }
    }

    Shortcut {
        name: "global:toggleMpris"
        description: "Toggle mpris state"
        onPressed: {
            if (!Config.modules.mpris || States.currentTopLevelFullscreen)
                return;
            ModulesState.toggleMpris();
        }
    }

    Shortcut {
        name: "global:areaScreenshot"
        description: "Open an area picker to take a screenshot using grim"
        onPressed: {
            ModulesState.toggleAreaPicker(AreaPicker.Screenshot);
        }
    }

    Shortcut {
        name: "global:fullScreenshot"
        description: "Take a screenshot of the fullscreen"
        onPressed: {
            States.updateCurrentScreen();
            let currentScreen = States.currentScreen;
            ScreenshotManager.capture(Qt.rect(0, 0, currentScreen.width, currentScreen.height));
        }
    }
}
