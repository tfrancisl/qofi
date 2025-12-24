pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

import "GridMode/"
import "ListMode/"

PanelWindow {
    id: root
    color: "transparent"

    property list<var> launchers: [grid, list]
    property var launcher: launchers[0]
    property int currentLauncherIndex: 0
    focusable: true

    property double shellScale: (2 / 3)
    property double shellAspectRatio: 16 / 9

    implicitWidth: Math.round(screen.height * shellAspectRatio * shellScale)
    implicitHeight: Math.round(screen.height * shellScale)

    function cycleLauncher() {
        currentLauncherIndex = (currentLauncherIndex + 1) % launchers.length;
        launcher = launchers[currentLauncherIndex];
    }

    function safeIncreaseShellScale() {
        shellScale = Math.min(shellScale * 1.1, 5.0);
    }

    function safeDecreaseShellScale() {
        shellScale = Math.max(shellScale * 0.9, 0.2);
    }

    function resetShellScale() {
        shellScale = 1.0;
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10

        color: "#CC000000"
        border.color: "#CC454545"
        border.width: 3
        radius: 5

        focus: true

        Shortcut {
            context: Qt.WindowShortcut
            sequence: "Shift+D"
            onActivated: root.cycleLauncher()
        }
        Shortcut {
            context: Qt.WindowShortcut
            sequence: "Shift+="
            onActivated: root.safeIncreaseShellScale()
        }
        Shortcut {
            context: Qt.WindowShortcut
            sequence: "Shift+-"
            onActivated: root.safeDecreaseShellScale()
        }
        Shortcut {
            context: Qt.WindowShortcut
            sequence: "Shift+R"
            onActivated: root.resetShellScale()
        }

        Keys.onEscapePressed: event => {
            event.accepted = true;
            Qt.quit();
        }

        ColumnLayout {
            anchors.fill: parent

            InfoPanel {
                shellScale: root.shellScale
            }

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
