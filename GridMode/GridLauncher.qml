pragma ComponentBehavior: Bound
import QtQuick

import "../Models"

Item {
    id: root

    required property real shellScale

    anchors.fill: parent

    GridView {
        anchors.fill: parent
        anchors.margins: 8
        model: LauncherModel.apps
        clip: true
        cellWidth: 64 * root.shellScale
        cellHeight: 64 * root.shellScale

        delegate: AppEntry {
            entry: modelData
            size: 58 * root.shellScale

            onClicked: {
                Qt.quit();
            }
        }
    }
}
