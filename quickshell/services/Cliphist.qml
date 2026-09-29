pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Caelestia
import Caelestia.Config

Singleton {
    id: root

    property string cliphistBinary: "cliphist"
    property real pasteDelay: 0.05
    property string pressPasteCommand: "ydotool key -d 1 29:1 47:1 47:0 29:0"
    property var entries: []

    function fuzzyQuery(search) {
        if (search.trim() === "")
            return entries;

        const query = search.toLowerCase();
        return entries.filter(function(entry) { return entry.toLowerCase().includes(query); });
    }

    function entryIsImage(entry) {
        return /^\d+\t\[\[.*binary data.*\d+x\d+.*\]\]$/.test(entry);
    }

    function refresh() {
        readProc.buffer = [];
        readProc.running = true;
    }

    function copy(entry) {
        Quickshell.execDetached(["bash", "-c", "printf '%s' '" + escapeShell(entry) + "' | " + root.cliphistBinary + " decode | wl-copy"]);
    }

    function paste(entry) {
        Quickshell.execDetached(["bash", "-c", "printf '%s' '" + escapeShell(entry) + "' | " + root.cliphistBinary + " decode | wl-copy && wl-paste"]);
    }

    function superpaste(count, isImage) {
        if (isImage === undefined) isImage = false;
        const targetEntries = entries.filter(function(entry) {
            if (!isImage) return true;
            return entryIsImage(entry);
        }).slice(0, count);
        const pasteCommands = targetEntries.reverse().map(function(entry) {
            return "printf '%s' '" + escapeShell(entry) + "' | " + root.cliphistBinary + " decode | wl-copy && sleep " + root.pasteDelay + " && " + root.pressPasteCommand;
        });
        Quickshell.execDetached(["bash", "-c", pasteCommands.join(" && sleep " + root.pasteDelay + " && ")]);
    }

    function deleteEntry(entry) {
        deleteProc.entry = entry;
        deleteProc.running = true;
    }

    function wipe() {
        root.entries = [];
        wipeProc.running = true;
    }

    function escapeShell(s) {
        return s.replace(/'/g, "'\\''");
    }

    Connections {
        function onClipboardTextChanged() {
            delayedUpdateTimer.restart();
        }

        target: Quickshell
    }

    Timer {
        id: delayedUpdateTimer
        interval: 100
        repeat: false
        onTriggered: root.refresh()
    }

    Process {
        id: readProc
        property var buffer: []
        command: [root.cliphistBinary, "list"]

        stdout: SplitParser {
            onRead: function(line) {
                readProc.buffer.push(line);
            }
        }

        onExited: function(exitCode, exitStatus) {
            if (exitCode === 0)
                root.entries = readProc.buffer;
            else
                root.entries = [];
        }
    }

    Process {
        id: deleteProc
        property string entry: ""
        command: ["bash", "-c", "echo '" + root.escapeShell(deleteProc.entry) + "' | " + root.cliphistBinary + " delete"]

        onExited: root.refresh()
    }

    Process {
        id: wipeProc
        command: ["bash", "-c", root.cliphistBinary + " wipe; rm -rf ~/.cache/cliphist/db"]

        onExited: function() { root.entries = []; }
    }

    IpcHandler {
        target: "cliphist"

        function update() {
            root.refresh();
        }
    }
}
