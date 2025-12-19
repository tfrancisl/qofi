import Quickshell
import QtQuick.Layouts
import QtQuick

Rectangle {
    id: root
    required property var desktopEntry
    required property var desktopActionEntry

    property bool isHovered: mouseArea.containsMouse
    border.width: root.isHovered ? 2 : 0
    border.color: root.isHovered ? "#41D8D5" : "transparent"
    color: root.isHovered ? "#555555" : "#3A3A3A"
    anchors.fill: parent
    radius: 5

    RowLayout {
        property int actionIndex
        anchors.fill: parent
        anchors.margins: 4
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            source: Quickshell.iconPath(root.desktopEntry.icon, "application-x-generic")
        }

        Text {
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
            text: root.desktopActionEntry ? root.desktopActionEntry.name : root.desktopEntry.name
            color: "#ffffff"
            font.pixelSize: 14
        }

        Text {
            Layout.alignment: Qt.AlignRight
            text: root.desktopActionEntry ? root.desktopActionEntry.execString : root.desktopEntry.execString
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
