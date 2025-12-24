pragma ComponentBehavior: Bound
import QtQuick

import "../Models"

GridView {
    id: root

    property int itemsPerRow: 16
    property var scaledCellHeight: ((parent.width - 2 * anchors.margins) / root.itemsPerRow)
    property int appEntrySize: (root.scaledCellHeight - 2)

    anchors.fill: parent
    anchors.margins: Math.min(24, 8)

    model: LauncherModel.apps

    clip: true
    cellWidth: scaledCellHeight
    cellHeight: scaledCellHeight

    delegate: AppEntry {
        entry: modelData
        size: root.appEntrySize

        onClicked: {
            Qt.quit();
        }
    }
}
