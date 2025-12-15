import Quickshell
import QtQuick

Rectangle {
    id: root

    required property var entry
    required property int index
    required property var modelData
    property bool isSelected: false

    signal clicked()

    width: parent.width
    height: 48
    color: {
        if (isSelected) return "#3e3e3e"
        if (mouseArea.containsMouse) return "#353535"
        return "#2a2a2a"
    }
    border.width: isSelected ? 2 : 0
    border.color: "#4a90e2"
    radius: 4

    Row {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 12

        Image {
            width: 32
            height: 32
            source: Quickshell.iconPath(entry.icon, "application-x-generic")
            sourceSize.width: 32
            sourceSize.height: 32
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2
            width: parent.width - 44

            Text {
                text: entry.name
                color: "#ffffff"
                font.pixelSize: 14
                font.bold: true
                elide: Text.ElideRight
                width: parent.width
            }

            Text {
                text: entry.genericName || entry.comment || ""
                color: "#888888"
                font.pixelSize: 11
                elide: Text.ElideRight
                width: parent.width
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            LauncherModel.selectedIndex = index
        }

        onClicked: {
            entry.execute()
            // Signal to parent to hide launcher
            root.clicked()
        }
    }
}
