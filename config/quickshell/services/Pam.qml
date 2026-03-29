import Quickshell.Services.Pam

import qs.utils

PamContext {
    id: pam
    property string password: ""

    function login(password: string): void {
        if (pam.active)
            pam.abort();
        pam.password = password;
        pam.start();
    }

    onResponseRequiredChanged: {
        if (pam.responseRequired && !!pam.password) {
            pam.respond(pam.password);
            pam.password = "";
        }
    }
    onCompleted: result => {
        if (result == PamResult.Success) {
            States.sessionLocked = false;
        }
    }
}
