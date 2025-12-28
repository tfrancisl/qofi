pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

import "GridMode/"
import "ListMode/"

FloatingWindow {
    id: root
    color: "transparent"

    property list<var> launchers: [grid, list]
    property int currentLauncherIndex: 0
    property var launcher: launchers[currentLauncherIndex]

    property double shellScale: (2 / 3)
    property double shellAspectRatio: 16 / 9

    implicitWidth: Math.round(screen.height * shellAspectRatio * shellScale)
    implicitHeight: Math.round(screen.height * shellScale)

    function cycleLauncher() {
        currentLauncherIndex = (currentLauncherIndex + 1) % launchers.length;
    }

    Shortcut {
        context: Qt.WindowShortcut
        sequence: "Shift+D"
        onActivated: root.cycleLauncher()
    }

    Shortcut {
        context: Qt.WindowShortcut
        sequence: "Esc"
        onActivated: Qt.quit()
    }

    Rectangle {
        anchors.fill: parent

        color: "#CC000000"
        radius: 5

        focus: true

        Component {
            id: grid
            GridLauncher {}
        }

        Component {
            id: list
            ListLauncher {}
        }

        Loader {
            id: launcherLoader
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                margins: 12
            }
            sourceComponent: root.launcher
        }

        Text {
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: 5.5
            }
            text: "freya :: qofi"
            font {
                pixelSize: 10
                italic: true
            }
            color: "#1F1F1F"
        }
    }
}
