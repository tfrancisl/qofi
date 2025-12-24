pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    required property real shellScale

    implicitHeight: 50
    Layout.fillWidth: true
    color: "black"
    border.color: "#454545"
    border.width: 3
    radius: 5

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12

        Text {
            text: "Shift+=\nIncrease Scale"
            color: "#999999"
            font.pixelSize: 12
        }

        Text {
            text: "Shift+-\nDecrease Scale"
            color: "#999999"
        }

        Text {
            text: "Current Scale: " + root.shellScale.toFixed(2)
            color: "#FFFFFF"
        }

        Text {
            text: "Shift+R\nReset Scale"
            color: "#999999"
        }

        Text {
            text: "Shift+D\nToggle Mode"
            color: "#999999"
        }

        Text {
            text: "ESC\nQuit"
            color: "#999999"
        }
    }
}
