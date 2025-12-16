import QtQuick
import QtQuick.Layouts

Rectangle {
    id: launcher
    anchors.fill: parent
    color: "#1e1e1e"
    radius: 8
    border.width: 1
    border.color: "#24272A"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Search input
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: "#24272A"
            border.width: 1
            border.color: "#41d8d5"
            radius: 4

            TextInput {
                id: searchInput
                anchors.fill: parent
                anchors.margins: 10

                text: ""
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
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: LauncherModel.filteredApps
            spacing: 2
            clip: true

            delegate: ListAppEntry {
                width: ListView.view.width
                entry: modelData
                isSelected: index === LauncherModel.selectedIndex

                onClicked: {
                    Qt.quit();
                }
            }
        }
    }
}
