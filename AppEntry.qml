import Quickshell
import QtQuick.Layouts
import QtQuick

Rectangle {
    id: root

    required property var entry
    required property int index
    required property var modelData
    property bool isSelected: false

    signal clicked

    width: parent.width
    height: 48
    color: {
        if (isSelected)
            return "#3e3e3e";
        if (mouseArea.containsMouse)
            return "#353535";
        return "#2a2a2a";
    }
    border.width: isSelected ? 1 : 0
    border.color: "#41d8d5"
    radius: 4

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32

            source: Quickshell.iconPath(root.entry.icon, "application-x-generic")
            sourceSize.width: 32
            sourceSize.height: 32
        }

        Column {
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: (1 / 2) * (parent.width - 32)
            spacing: 3

            Text {
                text: root.entry.name
                color: "#ffffff"
                font.pixelSize: 14
            }

            Text {
                text: root.entry.genericName || root.entry.comment || ""
                color: "#888888"
                font.pixelSize: 12
            }
        }

        Column {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: (parent.width - 32) / 4
            spacing: 1

            Repeater {
                model: root.entry.actions.map(a => a.name)
                delegate: Text {
                    required property var modelData
                    text: modelData
                    color: "#888888"
                    font.pixelSize: 10
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignRight
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: (parent.width - 32) / 4
            text: root.entry.execString
            color: "#888888"
            font.pixelSize: 12
            wrapMode: Text.WrapAnywhere
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            LauncherModel.selectedIndex = root.index;
        }

        onClicked: {
            root.entry.execute();
            // Signal to parent to hide launcher
            root.clicked();
        }
    }
}
