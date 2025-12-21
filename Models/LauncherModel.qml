pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property list<DesktopEntry> allApps: DesktopEntries.applications.values
    property list<DesktopEntry> apps: allApps.filter(entry => !entry.noDisplay).sort((a, b) => a.name.localeCompare(b.name))

    // TODO refactor filters/sorts to make a "relevance" score. name, then keywords, then description as priority
    function queryEntries(query) {
        const lowerQuery = query.toLowerCase();
        return query ? apps.filter(entry => entry.name.toLowerCase().includes(lowerQuery) || (entry.genericName && entry.genericName.toLowerCase().includes(lowerQuery))) : apps;
    }
}
