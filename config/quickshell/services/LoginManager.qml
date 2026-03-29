pragma Singleton
import Quickshell.Services.Pam

import qs.utils

PamContext {
    id: root
    property string password: ""

    function login(password: string): void {
        if (root.active)
            root.abort();
        root.password = password;
        root.start();
    }

    onResponseRequiredChanged: {
        if (root.responseRequired && !!root.password) {
            root.respond(root.password);
            root.password = "";
        }
    }
    onCompleted: result => {
        if (result == PamResult.Success) {
            States.sessionLocked = false;
        }
    }
}
