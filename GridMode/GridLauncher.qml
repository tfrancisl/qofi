pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import "../Models"

Item {
    id: root
    property double entryHeight: 100
    property double entryWidth: 100
    property double entryAspectRatio: (entryWidth / entryHeight)
    property double expandedEntryHeight: 300
    property double expandedEntryWidth: 500

    GridLayout {
        columns: 10
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 12
        }
        rowSpacing: 16
        columnSpacing: 4

        Repeater {
            model: LauncherModel.apps

            delegate: LaunchEntry {
                entry: modelData

                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: entryExpanded ? root.expandedEntryHeight : root.entryHeight
                Layout.preferredWidth: entryExpanded ? root.expandedEntryWidth : root.entryWidth
                Layout.rowSpan: entryExpanded ? (root.expandedEntryHeight / root.entryHeight) : 1
                Layout.columnSpan: entryExpanded ? (root.expandedEntryWidth / root.entryWidth) : 1
                onActivated: Qt.quit()
            }
        }
    }
}
