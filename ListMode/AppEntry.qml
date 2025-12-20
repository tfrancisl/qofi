pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Item {
    id: root

    required property var desktopEntry
    required property int index
    required property var modelData

    property int entryHeight: 48
    property int maxUnclippedPopupEntries: 4
    property int popupMargin: 12

    signal clicked

    ComboBox {
        id: selector
        anchors.fill: parent
        model: ["app", ...root.desktopEntry.actions]
        hoverEnabled: true

        contentItem: Rectangle {

            property bool isHovered: contentMouseArea.containsMouse
            border.width: isHovered ? 2 : 1
            border.color: isHovered ? "#41D8D5" : "transparent"
            color: isHovered ? "#333333" : "#222222"
            radius: 5

            AppEntryContent {
                anchors.fill: parent
                desktopEntry: root.desktopEntry
                visible: !selector.popup.visible
            }

            MouseArea {
                id: contentMouseArea
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.NoButton
            }
        }

        delegate: ItemDelegate {
            id: delegate

            required property var model
            required property int index

            width: parent.width - 2 * root.popupMargin
            height: root.entryHeight

            contentItem: Rectangle {
                property bool isHovered: popupMouseArea.containsMouse
                border.width: isHovered ? 2 : 0
                border.color: isHovered ? "#41D8D5" : "transparent"
                color: isHovered ? "#555555" : "#3A3A3A"
                anchors.fill: parent
                radius: 5

                PopupEntry {
                    id: popupEntry
                    anchors.fill: parent
                    desktopEntry: root.desktopEntry
                    // messy, but we know the app itself is in index 0
                    desktopActionEntry: delegate.index === 0 ? null : delegate.model.modelData
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
            width: parent.width - 2 * root.popupMargin
            x: 2 * root.popupMargin

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
                width: parent.width - 2 * root.popupMargin
                color: "black"
                border.width: 2
                border.color: "#20AAD5"
                radius: 5
            }
        }

        background: Item {}
        indicator: Canvas {}

        onActivated: index => {
            if (index === 0) {
                root.desktopEntry.execute();
                return;
            }
            model[index].execute();
        }
    }
}
