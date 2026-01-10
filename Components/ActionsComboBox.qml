pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    required property var desktopEntry
    required property var maxUnclippedPopupEntries
    property bool isHovered: actionMouseArea.containsMouse
    property bool entryHasActions: desktopEntry.actions.length !== 0

    signal clicked

    MouseArea {
        id: actionMouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }

    Loader {
        anchors.fill: parent
        sourceComponent: root.entryHasActions ? appActionsBox : noActions
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
                border.width: root.isHovered ? 2 : 0
                border.color: "#41D8D5"
                color: root.isHovered ? "#333333" : "#222222"
                radius: 5

                Text {
                    anchors.centerIn: parent
                    color: "#AAAAAA"
                    text: "Actions for " + root.desktopEntry.name
                }

                Rectangle {
                    anchors {
                        left: parent.left
                        bottom: parent.bottom
                        top: parent.top
                    }
                    width: 30
                    height: parent.height
                    color: "#41D8D5"
                    radius: 12
                    Text {
                        anchors.centerIn: parent
                        color: "black"
                        text: selector.model.length < 10 ? selector.model.length.toString() : "9+"
                        font.pixelSize: 15
                        font.weight: Font.Bold
                    }
                }
            }

            delegate: ItemDelegate {
                id: delegate

                required property var model
                required property int index
                property var desktopActionEntry: model.modelData

                width: parent.width
                height: root.height

                contentItem: Rectangle {
                    property bool isHovered: popupMouseArea.containsMouse
                    border.width: isHovered ? 2 : 0
                    border.color: "#41D8D5"
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

                    property int tooFewEntriesHeight: (count * root.height) + (count * spacing) + (anchors.margins)
                    property int tooManyEntriesHeight: (root.height * root.maxUnclippedPopupEntries) + (count * spacing)
                    implicitHeight: Math.min(tooFewEntriesHeight, tooManyEntriesHeight)
                }

                background: Rectangle {
                    width: parent.width
                    color: "black"
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
