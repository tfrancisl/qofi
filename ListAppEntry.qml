pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Item {
    id: root

    required property var entry
    required property int index
    required property var modelData

    property int actionPopupMargin: 12

    signal clicked

    ComboBox {
        id: appActionsSelector
        property var desktopEntry: root.entry
        anchors.fill: parent
        model: ["app", ...root.entry.actions]

        // Component shown before clicking anything
        contentItem: ActionOrAppEntry {
            desktopEntry: appActionsSelector.desktopEntry
            visible: !appActionsSelector.popup.visible
        }

        delegate: ItemDelegate {
            id: delegate

            required property var model
            required property int index
            width: parent.width - 2 * root.actionPopupMargin
            height: 48

            contentItem: ActionOrAppEntry {
                desktopEntry: appActionsSelector.desktopEntry
                // messy, but we know the app itself is in index 0
                desktopActionEntry: delegate.index === 0 ? null : delegate.model.modelData
            }
            background: Item {}
        }

        popup: Popup {
            height: contentItem.implicitHeight
            width: parent.width - 2 * root.actionPopupMargin
            x: 2 * root.actionPopupMargin

            contentItem: ListView {
                clip: true
                anchors {
                    fill: parent
                    margins: 4.5
                }
                // Fix these magic numbers pls :)
                implicitHeight: Math.min(contentHeight + 10, 48 * 4)
                model: appActionsSelector.popup.visible ? appActionsSelector.delegateModel : null
                currentIndex: appActionsSelector.highlightedIndex
                spacing: 5
            }

            background: Rectangle {
                width: parent.width - 2 * root.actionPopupMargin
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
                root.entry.execute();
                return;
            }
            model[index].execute();
        }
    }
}
