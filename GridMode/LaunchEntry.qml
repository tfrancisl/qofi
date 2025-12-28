pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    required property var modelData
    required property var entry

    property bool entryExpanded: {
        if (entry.name === "Alacritty")
            return true;
        false;
    }
    property var preferredIconSize: (2 / 3) * width

    signal activated
    onActivated: entry.execute()

    signal expanded
    onExpanded: entryExpanded = !entryExpanded

    Component {
        id: unexpandedEntry

        Rectangle {
            anchors.fill: parent

            border.width: mouseArea.containsMouse ? 2 : 0
            border.color: "#41D8D5"
            color: mouseArea.containsMouse ? "#333333" : "#222222"
            radius: 5

            Image {
                id: icon
                anchors.centerIn: parent
                width: root.preferredIconSize
                height: root.preferredIconSize
                source: Quickshell.iconPath(root.entry.icon)
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

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        root.activated();
                    } else if (mouse.button === Qt.RightButton) {
                        root.expanded();
                    }
                }
            }
        }
    }

    Component {
        id: expandedEntry
        Rectangle {
            anchors.fill: parent

            border.width: 4
            border.color: "#41D8D5"
            color: "#333333"
            radius: 5

            RowLayout {
                anchors.fill: parent
                ColumnLayout {
                    Layout.leftMargin: parent.width * (1 / 16)

                    Image {
                        id: icon
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: root.preferredIconSize / 4
                        Layout.preferredHeight: root.preferredIconSize / 4
                        source: Quickshell.iconPath(root.entry.icon)
                    }

                    Text {
                        Layout.alignment: Qt.AlignCenter
                        text: root.entry.name
                        color: "#BBBBBB"
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.topMargin: 25
                        Layout.bottomMargin: 25
                        RowLayout {
                            anchors.fill: parent
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                text: "App Launch Command"
                                color: "#BBBBBB"
                            }
                            Text {
                                wrapMode: Text.WrapAnywhere
                                text: root.entry.execString
                                color: "#888888"
                            }
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.topMargin: 25
                        Layout.bottomMargin: 25
                        RowLayout {
                            anchors.fill: parent
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                text: "App Launch Command"
                                color: "#BBBBBB"
                            }
                            Text {
                                wrapMode: Text.WrapAnywhere
                                text: root.entry.execString
                                color: "#888888"
                            }
                        }
                    }
                }
            }
        }
    }

    Loader {
        anchors.fill: parent
        sourceComponent: root.entryExpanded ? expandedEntry : unexpandedEntry
    }
}
