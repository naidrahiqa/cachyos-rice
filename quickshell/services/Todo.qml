pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Caelestia
import Caelestia.Config
import qs.utils

Singleton {
    id: root

    property string filePath: "file://" + Paths.config + "/todo.json"
    property var list: []

    function addItem(item) {
        list.push(item);
        root.list = list.slice(0);
        todoFileView.setText(JSON.stringify(root.list));
    }

    function addTask(desc) {
        addItem({"content": desc, "done": false});
    }

    function markDone(index) {
        if (index >= 0 && index < list.length) {
            list[index].done = true;
            root.list = list.slice(0);
            todoFileView.setText(JSON.stringify(root.list));
        }
    }

    function markUnfinished(index) {
        if (index >= 0 && index < list.length) {
            list[index].done = false;
            root.list = list.slice(0);
            todoFileView.setText(JSON.stringify(root.list));
        }
    }

    function deleteItem(index) {
        if (index >= 0 && index < list.length) {
            list.splice(index, 1);
            root.list = list.slice(0);
            todoFileView.setText(JSON.stringify(root.list));
        }
    }

    function refresh() {
        todoFileView.reload();
    }

    Component.onCompleted: refresh()

    FileView {
        id: todoFileView
        path: root.filePath

        onLoaded: function() {
            try {
                root.list = JSON.parse(text());
            } catch (e) {
                root.list = [];
                todoFileView.setText("[]");
            }
        }

        onLoadFailed: function(error) {
            if (error === FileViewError.FileNotFound) {
                root.list = [];
                todoFileView.setText("[]");
            }
        }
    }
}
