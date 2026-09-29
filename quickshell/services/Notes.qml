pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Caelestia
import Caelestia.Config
import qs.utils

Singleton {
    id: root

    property string filePath: "file://" + Paths.config + "/notes.json"
    property var list: []

    function addNote(content, attachments) {
        const id = Date.now().toString() + "-" + Math.floor(Math.random() * 10000);
        const item = {
            "id": id,
            "content": content || "",
            "attachments": attachments || [],
            "createdAt": Date.now()
        };
        list.push(item);
        root.list = list.slice(0);
        notesFileView.setText(JSON.stringify(root.list));
        return id;
    }

    function updateNote(id, content, attachments) {
        const idx = list.findIndex(function(n) { return n.id === id; });
        if (idx >= 0) {
            list[idx].content = content;
            if (attachments !== undefined)
                list[idx].attachments = attachments;
            root.list = list.slice(0);
            notesFileView.setText(JSON.stringify(root.list));
        }
    }

    function deleteNote(id) {
        const idx = list.findIndex(function(n) { return n.id === id; });
        if (idx >= 0) {
            list.splice(idx, 1);
            root.list = list.slice(0);
            notesFileView.setText(JSON.stringify(root.list));
        }
    }

    function refresh() {
        notesFileView.reload();
    }

    Component.onCompleted: refresh()

    FileView {
        id: notesFileView
        path: root.filePath

        onLoaded: function() {
            try {
                const parsed = JSON.parse(text());
                root.list = Array.isArray(parsed) ? parsed : [];
            } catch (e) {
                root.list = [];
                notesFileView.setText("[]");
            }
        }

        onLoadFailed: function(error) {
            if (error === FileViewError.FileNotFound) {
                root.list = [];
                notesFileView.setText("[]");
            }
        }
    }
}
