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

    property real shellScale: 1.0

    implicitWidth: screen.width * (1 / 2)
    implicitHeight: screen.height * (2 / 5)

    anchors {
        right: true
        left: true
        top: true
        bottom: true
    }

    margins {
        left: implicitWidth / 2
        right: implicitWidth / 2
        top: implicitHeight / 2
        bottom: implicitHeight / 2
    }

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

            Rectangle {
                id: topPanel
                implicitHeight: 50
                Layout.fillWidth: true
                color: "black"
                border.color: "#454545"
                border.width: 3
                radius: 5

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 5

                    Text {
                        text: "Shift+=\nIncrease Scale"
                        color: "#999999"
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
                        text: "Shift+R\nReset"
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

            Component {
                id: grid
                GridLauncher {
                    shellScale: root.shellScale
                }
            }

            Component {
                id: list
                ListLauncher {
                    shellScale: root.shellScale
                }
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
