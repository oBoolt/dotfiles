import QtQuick

import qs.components
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
}
