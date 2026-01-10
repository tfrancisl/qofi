pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    required property var desktopEntry
    required property var maxUnclippedPopupEntries
    required property var theme

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
                border.color: root.theme.accentColorDark
                color: root.isHovered ? root.theme.entryBackgroundColor : root.theme.entryHoveredBackgroundColor
                radius: 5

                Text {
                    anchors.centerIn: parent
                    color: root.theme.entryTextColorDark
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
                    color: root.theme.accentColorDark
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
                    border.color: root.theme.accentColorDark
                    color: isHovered ? root.theme.entryBackgroundColor : root.theme.entryHoveredBackgroundColor
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
                            color: root.theme.entryTextColorLight
                            font.pixelSize: 14
                        }

                        Text {
                            Layout.alignment: Qt.AlignRight
                            text: delegate.desktopActionEntry.execString
                            color: root.theme.entryTextColorAccent1
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
                    color: root.theme.backgroundColor
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
