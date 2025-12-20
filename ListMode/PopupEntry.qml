import Quickshell
import QtQuick.Layouts
import QtQuick

Item {
    id: root
    required property var desktopEntry
    required property var desktopActionEntry

    RowLayout {
        property int actionIndex
        anchors.fill: parent
        anchors.margins: 4

        Image {
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            source: Quickshell.iconPath(root.desktopEntry.icon)
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
}
