import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons

Item {
  id: root

  property var pluginApi: null
  property var launcher: null
  property string name: "Gopass"
  property bool handleSearch: true
  property string supportedLayouts: "list"
  property bool supportsAutoPaste: false

  property var entries: []
  property bool loaded: false

  function init() {
    loadEntries()
  }

  function onOpened() {
    if (!loaded) loadEntries()
  }

  function handleCommand(searchText) {
    return searchText === ">gp" || searchText.startsWith(">gp ")
  }

  function commands() {
    return [{
      "name": ">gp",
      "description": "Search gopass passwords",
      "icon": "key",
      "isTablerIcon": true,
      "onActivate": function() {
        launcher.setSearchText(">gp ")
      }
    }]
  }

  function getResults(searchText) {
    if (!handleCommand(searchText)) return []

    var query = searchText.slice(3).trim().toLowerCase()

    if (!loaded) {
      return [{
        "name": "Loading gopass entries...",
        "description": "Running gopass ls --flat",
        "icon": "refresh",
        "isTablerIcon": true,
        "onActivate": function() {}
      }]
    }

    var results = []
    for (var i = 0; i < entries.length && results.length < 50; i++) {
      var entry = entries[i]
      if (query === "" || entry.toLowerCase().indexOf(query) !== -1) {
        results.push(formatEntry(entry))
      }
    }

    return results
  }

  function formatEntry(entry) {
    var parts = entry.split("/")

    return {
      "name": parts[parts.length - 1],
      "description": "Copy " + entry,
      "icon": "key",
      "isTablerIcon": true,
      "provider": root,
      "onActivate": function() {
        copyPassword(entry)
        launcher.close()
      }
    }
  }

  function loadEntries() {
    listProc.exec(["gopass", "ls", "--flat"])
  }

  function copyPassword(entry) {
    copyProc.exec(["gopass", "show", "-c", entry])
  }

  Process {
    id: listProc

    stdout: StdioCollector {
      onStreamFinished: {
        root.entries = this.text
          .split("\n")
          .map(function(x) { return x.trim() })
          .filter(function(x) { return x.length > 0 })

        root.loaded = true

        if (root.launcher) {
          root.launcher.updateResults()
        }
      }
    }
  }

  Process {
    id: copyProc
  }
}
