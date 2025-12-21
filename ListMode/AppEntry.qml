pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

Item {
    id: root

    required property var desktopEntry
    required property int index
    required property var modelData

    property int entryHeight: 48
    property int maxUnclippedPopupEntries: 4

    signal clicked

    RowLayout {
        anchors.fill: parent

        Rectangle {
            property bool isHovered: contentMouseArea.containsMouse
            border.width: isHovered ? 2 : 1
            border.color: isHovered ? "#41D8D5" : "transparent"
            color: isHovered ? "#333333" : "#222222"
            radius: 5
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
            Layout.fillHeight: true

            MouseArea {
                id: contentMouseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    root.desktopEntry.execute();
                    root.clicked();
                }
            }

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
                        text: root.desktopEntry.execString
                        color: "#AAAAAA"
                        font.italic: true
                        font.pixelSize: 10
                        wrapMode: Text.WrapAnywhere
                        width: parent.width - 25
                    }
                }
            }
        }

        Item {
            id: actions
            property bool isHovered: actionMouseArea.containsMouse
            property bool entryHasActions: root.desktopEntry.actions.length !== 0
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: entryHasActions ? 256 : 0
            Layout.fillHeight: true

            MouseArea {
                id: actionMouseArea
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.NoButton
            }

            Loader {
                anchors.fill: parent
                sourceComponent: actions.entryHasActions ? appActionsBox : noActions
            }

            Component {
                id: appActionsBox

                ComboBox {
                    id: selector
                    anchors.fill: parent
                    model: root.desktopEntry.actions
                    hoverEnabled: false // give hover to the mouseArea

                    contentItem: Rectangle {
                        anchors.fill: parent
                        border.width: actions.isHovered ? 2 : 1
                        border.color: actions.isHovered ? "#41D8D5" : "transparent"
                        color: actions.isHovered ? "#333333" : "#222222"
                        radius: 5

                        Text {
                            anchors.centerIn: parent
                            color: "#AAAAAA"
                            text: "Actions for " + root.desktopEntry.name
                        }
                    }

                    delegate: ItemDelegate {
                        id: delegate

                        required property var model
                        required property int index
                        property var desktopActionEntry: model.modelData

                        width: parent.width
                        height: root.entryHeight

                        contentItem: Rectangle {
                            property bool isHovered: popupMouseArea.containsMouse
                            border.width: isHovered ? 2 : 0
                            border.color: isHovered ? "#41D8D5" : "transparent"
                            color: isHovered ? "#555555" : "#3A3A3A"
                            anchors.fill: parent
                            radius: 5

                            ColumnLayout {
                                property int actionIndex
                                anchors.fill: parent
                                anchors.margins: 4

                                Text {
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.fillWidth: true
                                    text: delegate.desktopActionEntry.name
                                    color: "#FFFFFF"
                                    font.pixelSize: 14
                                }

                                Text {
                                    Layout.alignment: Qt.AlignRight
                                    text: delegate.desktopActionEntry.execString
                                    color: "#AAAAAA"
                                    font.italic: true
                                    font.pixelSize: 12
                                }
                            }

                            MouseArea {
                                id: popupMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                acceptedButtons: Qt.NoButton
                            }
                        }
                        background: Item {}
                    }

                    popup: Popup {
                        height: contentItem.implicitHeight
                        width: parent.width

                        contentItem: ListView {
                            id: entryList
                            model: selector.popup.visible ? selector.delegateModel : null

                            anchors {
                                fill: parent
                                margins: 5
                            }
                            spacing: 5
                            clip: true

                            property int tooFewEntriesHeight: (count * root.entryHeight) + (count * spacing) + (anchors.margins)
                            property int tooManyEntriesHeight: (root.entryHeight * root.maxUnclippedPopupEntries) + (count * spacing)
                            implicitHeight: Math.min(tooFewEntriesHeight, tooManyEntriesHeight)
                        }

                        background: Rectangle {
                            width: parent.width
                            color: "black"
                            border.width: 2
                            border.color: "#20AAD5"
                            radius: 5
                        }
                    }

                    background: Item {}
                    indicator: Canvas {}

                    onActivated: index => {
                        model[index].execute();
                        root.clicked();
                    }
                }
            }

            Component {
                id: noActions
                Item {}
            }
        }
    }
}
