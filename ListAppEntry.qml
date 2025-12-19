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

        contentItem: ListAppEntryContent {
            desktopEntry: root.desktopEntry
            visible: !selector.popup.visible
        }

        delegate: ItemDelegate {
            id: delegate

            required property var model
            required property int index
            width: parent.width - 2 * root.popupMargin
            height: root.entryHeight

            contentItem: ListPopupEntry {
                desktopEntry: root.desktopEntry
                // messy, but we know the app itself is in index 0
                desktopActionEntry: delegate.index === 0 ? null : delegate.model.modelData
            }
            background: Item {}
        }

        popup: Popup {
            height: contentItem.implicitHeight
            width: parent.width - 2 * root.popupMargin
            x: 2 * root.popupMargin

            contentItem: ListView {
                id: entryList
                clip: true
                anchors {
                    fill: parent
                    margins: 5
                }
                implicitHeight: Math.min(contentHeight + entryList.anchors.margins * 2, root.entryHeight * root.maxUnclippedPopupEntries)
                model: selector.popup.visible ? selector.delegateModel : null
                currentIndex: selector.highlightedIndex
                spacing: 5
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
