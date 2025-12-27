pragma ComponentBehavior: Bound
import QtQuick

Item {
    id: root

    required property var entry
    required property int index
    required property var modelData
    required property int size

    property bool entryExpanded: false

    width: size
    height: size

    signal leftClicked

    onLeftClicked: {
        Qt.quit();
    }

    Component {
        id: launchIcon
        LaunchEntry {
            entry: root.entry
            size: root.size

            onLeftClicked: {
                root.leftClicked();
            }
            onRightClicked: {
                root.entryExpanded = true;
            }
        }
    }

    Component {
        id: expandedEntry
        ExpandedEntry {
            entry: root.entry
            size: root.size

            onLeftClicked: {
                // root.leftClicked();
            }
            onRightClicked: {
                root.entryExpanded = false;
            }
        }
    }

    Loader {
        anchors.fill: parent
        sourceComponent: root.entryExpanded ? expandedEntry : launchIcon
    }
}
