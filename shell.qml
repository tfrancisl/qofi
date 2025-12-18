import Quickshell
import QtQuick
import QtQuick.Layouts

FloatingWindow {
    id: root
    color: "transparent"
    property list<var> launchers: [grid, list]
    property var launcher: launchers[1]
    property int currentLauncherIndex: 1

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

        // Having these here doesnt allow for variance by launcher, but putting them in the launcher borks
        // a callback mechanism is probably the best fix

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
        }
    }

    Loader {
        id: launcherLoader
        anchors.fill: parent
        sourceComponent: root.launcher
    }
}
