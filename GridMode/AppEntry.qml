import Quickshell
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    required property var entry
    required property int index
    required property var modelData
    required property int size

    property bool isHovered: mouseArea.containsMouse

    width: size
    height: size

    border.width: isHovered ? 2 : 1
    border.color: isHovered ? "#41D8D5" : "transparent"
    color: isHovered ? "#333333" : "#222222"
    radius: 5

    signal clicked

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        Image {
            anchors.centerIn: parent
            width: root.size * (3 / 4)
            height: root.size * (3 / 4)
            source: Quickshell.iconPath(root.entry.icon)
        }

        onClicked: mouse => {
            root.entry.execute();
            root.clicked();
        }

        ToolTip {
            visible: mouseArea.containsMouse

            contentItem: Text {
                text: root.entry.name
                color: "#888888"
            }

            background: Rectangle {
                color: "#da111111"
                border.color: "#111111"
            }
        }
    }
}
