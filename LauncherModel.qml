pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property var allApps: []
    property var filteredApps: []
    property string searchQuery: ""
    property int selectedIndex: 0
    property int loadAttempts: 0
    property int maxLoadAttempts: 10

    Component.onCompleted: {
        loadDesktopEntries();
    }

    // TODO refactor filters/sorts to make a "relevance" score. name, then keywords, then description as priority

    function loadDesktopEntries() {
        const apps = DesktopEntries.applications.values;

        if (apps.length === 0 && loadAttempts < maxLoadAttempts) {
            loadAttempts++;
            console.log(`DesktopEntries not ready, retry ${loadAttempts}/${maxLoadAttempts}...`);
            retryTimer.start();
            return;
        }

        if (apps.length === 0) {
            console.error(`Failed to load desktop entries after ${maxLoadAttempts} attempts`);
            return;
        }

        // Successfully loaded
        allApps = apps.filter(entry => !entry.noDisplay).sort((a, b) => a.name.localeCompare(b.name));

        filteredApps = allApps;
        console.log(`Loaded ${allApps.length} desktop entries (attempt ${loadAttempts + 1})`);
    }

    Timer {
        id: retryTimer
        interval: 100
        running: false
        repeat: false
        onTriggered: root.loadDesktopEntries()
    }

    function updateSearch(query) {
        searchQuery = query;
        const lowerQuery = query.toLowerCase();

        if (!query) {
            filteredApps = allApps;
        } else {
            filteredApps = allApps.filter(entry => entry.name.toLowerCase().includes(lowerQuery) || (entry.genericName && entry.genericName.toLowerCase().includes(lowerQuery)) ||
                // (entry.comment && entry.comment.toLowerCase().includes(lowerQuery))
                (entry.keywords && entry.keywords.some(k => k.toLowerCase().includes(lowerQuery))));
        }

        // Reset selection to first item after filtering
        selectedIndex = 0;
    }

    function selectNext() {
        if (selectedIndex < filteredApps.length - 1) {
            selectedIndex++;
        }
    }

    function selectPrevious() {
        if (selectedIndex > 0) {
            selectedIndex--;
        }
    }

    function launchSelected() {
        if (selectedIndex >= 0 && selectedIndex < filteredApps.length) {
            filteredApps[selectedIndex].execute();
        }
    }
}
