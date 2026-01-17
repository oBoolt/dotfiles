import QtQuick

Item {
    id: root
    default required property list<Component> pages
    property int currentPage: 0
    property alias active: loader.active

    function next(): void {
        if ((root.currentPage + 1) >= root.pages.length) {
            return;
        }

        root.currentPage++;
    }

    function previous(): void {
        if ((root.currentPage - 1) < 0) {
            return;
        }

        root.currentPage--;
    }

    function set(page: int): void {
        if (page >= root.pages.length || page < 0) {
            console.error(`'${page}' is not in range`);
            return;
        }
        root.currentPage = page;
    }

    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: root.pages[root.currentPage]
    }

    Component.onCompleted: {
        console.log(pages);
    }
}
