pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import "GridMode/"
import "ListMode/"

import "Themes/"

FloatingWindow {
    id: root
    color: "transparent"

    property list<var> launchers: [list, grid]
    property int currentLauncherIndex: 0
    property var launcher: launchers[currentLauncherIndex]

    property double shellScale: (2 / 3)
    property double shellAspectRatio: 16 / 9

    property var theme: LightTheme

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

        color: root.theme.backgroundColor
        radius: 5

        focus: true

        Component {
            id: grid
            GridLauncher {
                theme: root.theme
            }
        }

        Component {
            id: list
            ListLauncher {
                theme: root.theme
            }
        }

        Loader {
            id: launcherLoader
            anchors {
                fill: parent
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
            color: root.theme.subtleTextColor
        }
    }
}
