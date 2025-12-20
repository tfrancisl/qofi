import Quickshell
import QtQuick.Layouts
import QtQuick

Item {
    id: root
    required property var desktopEntry

    RowLayout {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
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
}
