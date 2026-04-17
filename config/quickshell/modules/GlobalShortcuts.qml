import QtQuick

import qs.components
import qs.config
import qs.utils

Item {
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
            if (!Config.modules.mpris)
                return;
            States.toggleMpris();
        }
    }
}
