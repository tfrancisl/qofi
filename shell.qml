import Quickshell
import QtQuick
import QtQuick.Layouts
import "GridMode/"
import "ListMode/"

PanelWindow {
    id: root
    color: "transparent"
    property list<var> launchers: [grid, list]
    property var launcher: launchers[1]
    property int currentLauncherIndex: 1
    focusable: true
    implicitHeight: screen.height
    implicitWidth: screen.width * 0.2

    anchors {
        right: true
    }

    function cycleLauncher() {
        currentLauncherIndex = (currentLauncherIndex + 1) % launchers.length;
        launcher = launchers[currentLauncherIndex];
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        focus: true
        color: "black"
        border.color: "#454545"
        border.width: 3
        radius: 5
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
