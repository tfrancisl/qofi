import Quickshell
import QtQuick.Layouts
import QtQuick

Rectangle {
    id: root

    required property var desktopEntry

    property bool isHovered: mouseArea.containsMouse
    anchors.fill: parent
    border.width: isHovered ? 2 : 1
    border.color: isHovered ? "#41D8D5" : "transparent"
    color: isHovered ? "#333333" : "#222222"
    radius: 5

    RowLayout {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            source: Quickshell.iconPath(root.desktopEntry.icon, "application-x-generic")
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
                text: root.desktopEntry.genericName || root.desktopEntry.comment || ""
                color: "#AAAAAA"
                font.pixelSize: 12
            }
        }

        Text {
            Layout.alignment: Qt.AlignRight
            text: root.desktopEntry.execString
            color: "#AAAAAA"
            font.italic: true
            font.pixelSize: 12
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
