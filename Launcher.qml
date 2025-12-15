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
            searchInput.forceActiveFocus();
            searchInput.text = "";
            LauncherModel.updateSearch("");
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#1e1e1e"
        radius: 8
        border.width: 1
        border.color: "#2a2a2a"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            // Search input
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                color: "#2a2a2a"
                border.width: 2
                border.color: "#4a90e2"
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

                    Keys.onDownPressed: event => {
                        LauncherModel.selectNext();
                        event.accepted = true;
                    }

                    Keys.onUpPressed: event => {
                        LauncherModel.selectPrevious();
                        event.accepted = true;
                    }

                    Keys.onReturnPressed: event => {
                        LauncherModel.launchSelected();
                        launcher.visible = false;
                        event.accepted = true;
                    }

                    Keys.onEscapePressed: event => {
                        launcher.visible = false;
                        event.accepted = true;
                    }
                }
            }

            // Application list
            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: LauncherModel.filteredApps
                spacing: 2
                clip: true

                delegate: AppEntry {
                    width: ListView.view.width
                    entry: modelData
                    isSelected: index === LauncherModel.selectedIndex

                    onClicked: {
                        launcher.visible = false;
                    }
                }
            }
        }
    }
}
