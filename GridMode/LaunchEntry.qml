pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Components"

Item {
    id: root
    required property var modelData
    required property var entry

    property bool entryExpanded: false
    property var preferredIconSize: (2 / 3) * width

    signal activated
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
                        root.entry.execute();
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
            id: expandedEntryBody
            anchors.fill: parent

            border.width: 4
            border.color: "#41D8D5"
            color: "#333333"
            radius: 5

            RowLayout {
                anchors.fill: parent
                ColumnLayout {
                    Layout.leftMargin: parent.width * (1 / 16)
                    Layout.rightMargin: parent.width * (1 / 16)

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

                    Component {
                        id: launchCommand
                        RowLayout {
                            Text {
                                text: "App Launch Command"
                                color: "#BBBBBB"
                            }
                            Text {
                                wrapMode: Text.WrapAnywhere
                                text: root.entry.execString
                                font.italic: true
                                color: "#888888"
                            }
                        }
                    }
                    Component {
                        id: appActions
                        ActionsComboBox {
                            id: actions

                            desktopEntry: root.entry
                            height: 25
                            maxUnclippedPopupEntries: 2

                            Layout.alignment: Qt.AlignRight
                            Layout.preferredWidth: entryHasActions ? parent.width * 0.4 : 0
                            Layout.fillHeight: true

                            onClicked: root.activated()
                        }
                    }

                    Repeater {
                        model: [launchCommand, appActions]

                        delegate: Rectangle {
                            id: delegate
                            required property var modelData
                            Layout.minimumWidth: expandedEntryBody.width * 0.6
                            Layout.minimumHeight: expandedEntryBody.height * 0.1
                            Layout.maximumHeight: expandedEntryBody.height * 0.3

                            border.width: 1
                            border.color: "#41D8D5"
                            color: "#333333"
                            radius: 5

                            Loader {
                                anchors.fill: parent
                                anchors.margins: 3
                                sourceComponent: delegate.modelData
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
