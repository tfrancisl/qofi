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
        if (mouse_area.containsMouse)
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
            id: app_icon
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            source: Quickshell.iconPath(root.entry.icon, "application-x-generic")
        }

        Column {
            id: app_info
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
            Layout.fillHeight: true
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

        Text {
            id: app_command_string
            Layout.alignment: Qt.AlignVCenter
            text: root.entry.execString
            color: "#888888"
            font.italic: true
            font.pixelSize: 12
        }
    }

    MouseArea {
        id: mouse_area
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
