pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import "../Components"

Item {
    id: root

    required property var desktopEntry
    required property int index
    required property var modelData

    property int entryHeight: 48
    property int maxUnclippedPopupEntries: 4
    property real shellScale: 1.0

    signal clicked

    RowLayout {
        id: outerLayout
        anchors.fill: parent
        height: root.entryHeight * root.shellScale

        AppButton {
            id: appButton

            desktopEntry: root.desktopEntry

            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: actions.entryHasActions ? (parent.width * 0.6 - outerLayout.spacing) : parent.width
            Layout.fillHeight: true

            onClicked: root.clicked()
        }

        ActionsComboBox {
            id: actions

            desktopEntry: root.desktopEntry
            entryHeight: root.entryHeight * root.shellScale
            maxUnclippedPopupEntries: root.maxUnclippedPopupEntries

            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: entryHasActions ? parent.width * 0.4 : 0
            Layout.fillHeight: true

            onClicked: root.clicked()
        }
    }
}
