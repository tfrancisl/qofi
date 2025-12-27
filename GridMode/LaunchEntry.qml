pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    required property var modelData
    required property var entry

    border.width: mouseArea.containsMouse ? 2 : 1
    border.color: mouseArea.containsMouse ? "#41D8D5" : "transparent"
    color: mouseArea.containsMouse ? "#333333" : "#222222"
    radius: 5

    signal leftClicked
    signal rightClicked

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        Image {
            anchors.centerIn: parent
            width: root.width * (3 / 4)
            height: root.height * (3 / 4)
            source: Quickshell.iconPath(root.entry.icon)
        }

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                root.entry.execute();
                root.leftClicked();
            } else if (mouse.button === Qt.RightButton) {
                root.rightClicked();
            }
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
