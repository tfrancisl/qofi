pragma ComponentBehavior: Bound
import QtQuick

Item {
    id: launcher
    anchors.fill: parent
    anchors.margins: 10

    Rectangle {
        id: searchBackground
        width: parent.width
        height: 35
        color: "#242424"
        border.width: 2
        border.color: "#20AAD5"
        radius: 5

        anchors.top: parent.top

        TextInput {
            id: searchInput
            anchors.fill: parent
            anchors.margins: 10

            font.pixelSize: 16
            color: "#ffffff"
            selectByMouse: true
            focus: true

            onTextEdited: {
                LauncherModel.updateSearch(text);
            }
        }
    }

    ListView {
        id: appList
        model: LauncherModel.filteredApps

        width: parent.width
        anchors.top: searchBackground.bottom
        anchors.bottom: parent.bottom
        anchors.margins: {
            top: 10;
        }
        spacing: 5
        clip: true

        delegate: ListAppEntry {
            width: appList.width
            height: 48
            entry: modelData

            onClicked: {
                Qt.quit();
            }
        }
    }
}
