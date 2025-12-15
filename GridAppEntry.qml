import Quickshell
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    required property var entry
    required property int index
    required property var modelData
    required property int size
    property bool isSelected: false

    signal clicked

    width: size
    height: size

    color: isSelected ? "#353535" : "#2a2a2a"

    border.width: isSelected ? 3 : 2
    border.color: isSelected ? "#41d8d5" : "#111111"
    radius: 4

    Image {
        id: app_icon
        anchors.centerIn: parent
        width: root.size * (3 / 4)
        height: root.size * (3 / 4)
        source: Quickshell.iconPath(root.entry.icon, "application-x-generic")
    }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            LauncherModel.selectedIndex = root.index;
        }

        onClicked: {
            // should expand into a focused view of that app
            // root.entry.execute();
            // Signal to parent to hide launcher
            root.clicked();
        }

        ToolTip {
            id: app_tooltip
            visible: root.isSelected || mouse_area.containsMouse
            text: root.entry.name

            contentItem: Text {
                text: app_tooltip.text
                font: app_tooltip.font
                color: "#888888"
            }

            background: Rectangle {
                color: "#da111111"
                border.color: "#111111"
            }
        }
    }
}
