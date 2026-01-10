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
    required property var theme

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
            border.color: root.theme.accentColorDark
            color: mouseArea.containsMouse ? root.theme.entryBackgroundColor : root.theme.entryHoveredBackgroundColor
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
                    color: root.theme.entryTextColorAccent2
                }

                background: Rectangle {
                    color: root.theme.backgroundColorAccent1
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
            border.color: root.theme.entryBorderColor
            color: root.theme.entryBackgroundColor
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
                        color: root.theme.entryTextColorDark
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true

                    Component {
                        id: launchCommand
                        RowLayout {
                            Text {
                                text: "App Launch Command"
                                color: root.theme.entryTextColorDark
                            }
                            Text {
                                wrapMode: Text.WrapAnywhere
                                text: root.entry.execString
                                font.italic: true
                                color: root.theme.entryTextColorAccent2
                            }
                        }
                    }
                    Component {
                        id: appActions
                        ActionsComboBox {
                            id: actions

                            theme: root.theme
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
                            border.color: root.theme.accentColorDark
                            color: root.theme.entryBackgroundColor
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
