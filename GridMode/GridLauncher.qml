import QtQuick

import "../Models"

Item {
    id: launcher
    anchors.fill: parent

    GridView {
        anchors.fill: parent
        anchors.margins: 8
        model: LauncherModel.allApps
        clip: true
        cellWidth: launcher.width / 16
        cellHeight: launcher.width / 16

        delegate: AppEntry {
            entry: modelData
            size: (parent.width / 16) - 6

            onClicked: {
                // Qt.quit();
            }
        }
    }
}
