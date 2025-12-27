pragma ComponentBehavior: Bound
import QtQuick

import "../Models"

// Rewrite to toggle between expanded entry and grid mode using signals
GridView {
    id: root

    property int itemsPerRow: 16
    property var scaledCellSize: ((parent.width - 2 * anchors.margins) / root.itemsPerRow)
    property int appEntrySize: (root.scaledCellSize - 2)

    anchors.fill: parent
    anchors.margins: Math.min(24, 8)

    model: LauncherModel.apps

    clip: true
    cellWidth: scaledCellSize
    cellHeight: scaledCellSize

    delegate: AppEntry {
        entry: modelData
        size: root.appEntrySize
    }
}
