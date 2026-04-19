import QtQuick

Item {
    enum Enum {
        Main,
        Audio,
        SystemInfo
    }

    signal pop
    signal push(int page)
}
