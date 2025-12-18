// Name obviously indicates something is off about this one
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import QtQuick

Item {
    id: root
    property bool isHovered: mouseArea.containsMouse
    property var desktopEntry: undefined
    property var desktopActionEntry: undefined

    anchors.fill: parent

    Component {
        id: appEntry
        Rectangle {
            anchors.fill: parent
            border.width: root.isHovered ? 2 : 1
            border.color: root.isHovered ? "#41D8D5" : "transparent"
            color: root.isHovered ? "#333333" : "#222222"
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
            function execute() {
                root.desktopEntry.execute();
            }
        }
    }
    Component {
        id: appActionEntry
        Rectangle {
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
                    text: root.desktopActionEntry.name
                    color: "#ffffff"
                    font.pixelSize: 14
                }

                Text {
                    Layout.alignment: Qt.AlignRight
                    text: root.desktopActionEntry.execString
                    color: "#AAAAAA"
                    font.italic: true
                    font.pixelSize: 12
                }
            }
            function execute() {
                root.desktopActionEntry.execute();
            }
        }
    }

    Loader {
        id: entryLoader
        anchors.fill: parent
        sourceComponent: {
            if (root.desktopActionEntry) {
                appActionEntry;
            } else if (root.desktopEntry) {
                appEntry;
            } else {
                undefined;
            }
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }

    function execute() {
        // Works but is obviously brittle
        entryLoader.item.execute();
    }
}
