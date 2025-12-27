pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import "../Models"

GridLayout {
    id: root
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
        margins: 8
    }

    columns: 10

    rowSpacing: 8
    columnSpacing: 8

    Repeater {
        model: LauncherModel.apps

        delegate: LaunchEntry {
            Layout.preferredHeight: entryExpanded ? 300 : 100
            Layout.preferredWidth: entryExpanded ? 300 : 100
            Layout.columnSpan: entryExpanded ? 3 : 1
            Layout.rowSpan: entryExpanded ? 3 : 1

            property bool entryExpanded: false

            entry: modelData

            onRightClicked: {
                entryExpanded = !entryExpanded;
            }
        }
    }
}
