import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    color: "transparent"
    property list<var> launchers: [grid, list]
    property var launcher: launchers[1]
    property int currentLauncherIndex: 1
    focusable: true

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    margins {
        top: screen.height * (1 / 4)
        bottom: screen.height * (1 / 4)
        left: screen.width * (1 / 3)
        right: screen.width * (1 / 3)
    }

    function cycleLauncher() {
        currentLauncherIndex = (currentLauncherIndex + 1) % launchers.length;
        launcher = launchers[currentLauncherIndex];
    }

    Rectangle {
        anchors.fill: parent
        focus: true
        color: "black"
        Shortcut {
            context: Qt.WindowShortcut
            sequence: "Shift+D"
            onActivated: root.cycleLauncher()
        }

        Keys.onEscapePressed: event => {
            event.accepted = true;
            Qt.quit();
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
            }
        }
    }
}
