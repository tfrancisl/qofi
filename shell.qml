import Quickshell
import QtQuick

FloatingWindow {
    id: root
    color: "transparent"
    property list<var> launchers: [grid, list]
    property var launcher: launchers[0]
    property int currentLauncherIndex: 0

    function cycleLauncher() {
        currentLauncherIndex = (currentLauncherIndex + 1) % launchers.length;
        launcher = launchers[currentLauncherIndex];
    }

    Rectangle {
        anchors.fill: parent
        focus: true
        Shortcut {
            context: Qt.WindowShortcut
            sequence: "Shift+D"
            onActivated: root.cycleLauncher()
        }

        // Having these here doesnt allow for variance by launcher, but putting them in the launcher borks
        Keys.onDownPressed: event => {
            LauncherModel.selectNext();
            event.accepted = true;
        }
        Keys.onRightPressed: event => {
            LauncherModel.selectNext();
            event.accepted = true;
        }
        Keys.onUpPressed: event => {
            LauncherModel.selectPrevious();
            event.accepted = true;
        }
        Keys.onLeftPressed: event => {
            LauncherModel.selectPrevious();
            event.accepted = true;
        }
        Keys.onEscapePressed: event => {
            event.accepted = true;
            Qt.quit();
        }

        Component {
            id: grid
            GridLauncher {}
        }

        Component {
            id: list
            ListLauncher {}
        }
    }

    Loader {
        id: launcherLoader
        anchors.fill: parent
        sourceComponent: root.launcher
    }
}
