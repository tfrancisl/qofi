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
    property var launcher: launchers[0]
    property int currentLauncherIndex: 0

    property double shellScale: (2 / 3)
    property double shellAspectRatio: 16 / 9

    implicitWidth: Math.round(screen.height * shellAspectRatio * shellScale)
    implicitHeight: Math.round(screen.height * shellScale)

    function cycleLauncher() {
        currentLauncherIndex = (currentLauncherIndex + 1) % launchers.length;
        launcher = launchers[currentLauncherIndex];
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10

        color: "#CC000000"
        border.color: "#CC454545"
        border.width: 3
        radius: 5

        focus: true

        Keys.onEscapePressed: event => {
            event.accepted = true;
            Qt.quit();
        }

        Shortcut {
            context: Qt.WindowShortcut
            sequence: "Shift+D"
            onActivated: root.cycleLauncher()
        }

        ColumnLayout {
            anchors.fill: parent

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
                Layout.fillHeight: true
                Layout.fillWidth: true
                sourceComponent: root.launcher

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
    }
}
