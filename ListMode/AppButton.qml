pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: root

    required property var desktopEntry
    property bool isHovered: mouseArea.containsMouse
    border.width: isHovered ? 2 : 1
    border.color: isHovered ? "#41D8D5" : "transparent"
    color: isHovered ? "#333333" : "#222222"
    radius: 5

    signal clicked

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.desktopEntry.execute();
            root.clicked();
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: parent.height
            Layout.preferredHeight: parent.height
            source: Quickshell.iconPath(root.desktopEntry.icon)
        }

        Column {
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 3

            Text {
                text: root.desktopEntry.name
                color: "#ffffff"
                font.pixelSize: 14
            }

            Text {
                text: root.desktopEntry.execString
                color: "#AAAAAA"
                font.italic: true
                font.pixelSize: 10
                wrapMode: Text.WrapAnywhere
                width: parent.width - 25
            }
        }
    }
}
