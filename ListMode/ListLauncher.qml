pragma ComponentBehavior: Bound
import QtQuick

import "../Models"

Item {
    id: root

    anchors.fill: parent
    anchors.margins: 10

    property real shellScale: 1.0
    property int listEntryHeight: 48

    Rectangle {
        id: searchBackground
        width: parent.width
        height: 35 * root.shellScale
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

            Keys.onEscapePressed: event => {
                text = "";
                focus = false;
            }
        }
    }

    ListView {
        id: appList

        model: LauncherModel.queryEntries(searchInput.text)

        width: parent.width
        anchors.top: searchBackground.bottom
        anchors.bottom: parent.bottom
        anchors.margins: {
            top: 10;
        }
        spacing: 5
        clip: true

        delegate: ListEntry {
            width: appList.width
            shellScale: root.shellScale
            height: root.listEntryHeight * root.shellScale
            entryHeight: root.listEntryHeight * root.shellScale
            desktopEntry: modelData

            onClicked: {
                Qt.quit();
            }
        }
    }
}
