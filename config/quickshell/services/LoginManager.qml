pragma Singleton
import Quickshell.Services.Pam

import qs.modules

PamContext {
    id: root
    property string password: ""
    property string result: "Unknown"

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
        root.result = PamResult.toString(result);
        if (result == PamResult.Success) {
            ModulesState.unlockSession();
        }
    }
}
