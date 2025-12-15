import Quickshell
import QtQuick
import QtQuick.Layouts

FloatingWindow {
    id: launcher
    visible: true
    implicitWidth: 600
    implicitHeight: 500
    color: "transparent"

    onVisibleChanged: {
        if (visible) {
            LauncherModel.updateSearch("");
        }
    }

    Rectangle {
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

                onTextEdited: {
                    LauncherModel.updateSearch(text);
                }

                Keys.onDownPressed: event => {
                    LauncherModel.selectNext();
                    event.accepted = true;
                }

                Keys.onRightPressed: event => {
                    LauncherModel.selectNext();
                    event.accepted = true;
                }

                Keys.onUpPressed: event => {
                    LauncherModel.selectPrevious();
                    event.accepted = true;
                }

                Keys.onLeftPressed: event => {
                    LauncherModel.selectPrevious();
                    event.accepted = true;
                }

                Keys.onReturnPressed: event => {
                    LauncherModel.launchSelected();
                    event.accepted = true;
                    Qt.quit();
                }

                Keys.onEscapePressed: event => {
                    event.accepted = true;
                    Qt.quit();
                }
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
                size: (launcher.width / 16) - 6
                isSelected: index === LauncherModel.selectedIndex

                onClicked: {
                    Qt.quit();
                }
            }
        }
    }
}
