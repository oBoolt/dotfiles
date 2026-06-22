import QtQuick

QtObject {
    component Bar: QtObject {
        property int height: 30
    }

    readonly property Bar bar: Bar {}
}
