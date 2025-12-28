pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import "../Models"

GridLayout {
    id: root
    columns: 10

    property double entryHeight: 100
    property double entryWidth: 100
    property double entryAspectRatio: (entryWidth / entryHeight)
    property double expandedEntryHeight: 300
    property double expandedEntryWidth: 500

    rowSpacing: 16
    columnSpacing: 4

    Repeater {
        model: LauncherModel.apps

        delegate: LaunchEntry {
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: entryExpanded ? root.expandedEntryHeight : root.entryHeight
            Layout.preferredWidth: entryExpanded ? root.expandedEntryWidth : root.entryWidth
            Layout.rowSpan: entryExpanded ? (root.expandedEntryHeight / root.entryHeight) : 1
            Layout.columnSpan: entryExpanded ? (root.expandedEntryWidth / root.entryWidth) : 1
            entry: modelData
            onActivated: Qt.quit()
        }
    }
}
