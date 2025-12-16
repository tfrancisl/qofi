import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: launcher
    anchors.fill: parent
    color: "#1e1e1e"
    radius: 8
    border.width: 1
    border.color: "#24272A"

    Rectangle {
        Layout.preferredWidth: 0
        Layout.preferredHeight: 0
        color: "transparent"
        border.color: "transparent"

        TextInput {
            id: searchInput
            anchors.fill: parent
            anchors.margins: 10

            color: "transparent"
            focus: true
        }
    }

    GridView {
        anchors.fill: parent
        anchors.margins: 8
        model: LauncherModel.filteredApps
        clip: true
        cellWidth: launcher.width / 16
        cellHeight: launcher.width / 16

        delegate: GridAppEntry {
            entry: modelData
            size: (parent.width / 16) - 6
            isSelected: index === LauncherModel.selectedIndex

            onClicked: {
                // Qt.quit();
            }
        }
    }
}
