pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Caelestia
import qs.utils

Singleton {
    id: root

    property string emojiFilePath: "file://" + Paths.config + "/emojis.txt"
    property var list: []

    readonly property var defaultEmojis: [
        "\ud83d\ude00", "\ud83d\ude03", "\ud83d\ude04", "\ud83d\ude01", "\ud83d\ude06", "\ud83d\ude05", "\ud83e\udd23", "\ud83d\ude02", "\ud83d\ude42", "\ud83d\ude43",
        "\ud83d\ude09", "\ud83d\ude0a", "\ud83d\ude07", "\ud83e\udd70", "\ud83d\ude0d", "\ud83e\udd29", "\ud83d\ude18", "\ud83d\ude17", "\ud83d\ude1a", "\ud83d\ude19",
        "\ud83e\udd72", "\ud83d\ude0b", "\ud83d\ude1c", "\ud83d\ude1d", "\ud83e\udd2a", "\ud83d\ude1e", "\ud83e\udd11", "\ud83d\ude14", "\ud83e\udd21", "\ud83e\udee3",
        "\ud83e\udd2b", "\ud83d\ude10", "\ud83e\udd14", "\ud83e\udee1", "\ud83d\ude12", "\ud83d\ude44", "\ud83d\ude2c", "\ud83e\udd25", "\ud83d\ude0c", "\ud83d\ude16",
        "\ud83e\udd73", "\ud83d\ude2a", "\ud83e\udd24", "\ud83d\ude34", "\ud83d\ude37", "\ud83e\udd12", "\ud83e\udd15", "\ud83e\udd22", "\ud83e\udd2e", "\ud83e\udd27",
        "\ud83e\udd75", "\ud83e\udd76", "\ud83e\udd18", "\ud83e\udd19", "\ud83e\udd7a", "\ud83e\udd1a", "\ud83d\ude08", "\ud83d\udc7f", "\ud83d\udc79", "\ud83d\udc7a",
        "\ud83d\udc7b", "\ud83d\udc80", "\ud83d\udc7d", "\ud83e\udd13", "\ud83e\udd11", "\ud83d\udc7e", "\ud83e\udd17", "\ud83e\udd1d", "\ud83e\udd1b", "\ud83e\udd1c",
        "\ud83d\udc4d", "\ud83d\udc4e", "\ud83d\udc4b", "\ud83d\udc4f", "\ud83e\udd1e", "\ud83e\udd1f", "\ud83e\udd18", "\ud83e\udd19", "\ud83e\udd1a", "\ud83e\udd1b",
        "\ud83d\udc46", "\ud83d\udc47", "\ud83d\udc48", "\ud83d\udc49", "\ud83e\udee5", "\ud83d\udc4a", "\ud83e\udd1c", "\ud83e\udd1b", "\ud83e\udd1d", "\ud83e\udd1d",
        "\u270a", "\ud83e\udd1c", "\ud83e\udd1b", "\ud83e\udd1e", "\ud83e\udd1f", "\ud83e\udee6", "\ud83e\udd18", "\ud83e\udd19", "\ud83e\udd1a", "\ud83e\udd1b",
        "\ud83d\udc4d", "\ud83d\udc4e", "\u270a", "\ud83d\udc4a", "\ud83e\udd1c", "\ud83e\udd1b", "\ud83e\udd1e", "\ud83e\udd1f", "\ud83e\udee6", "\ud83e\udd18",
        "\ud83d\udc46", "\ud83d\udc47", "\ud83d\udc48", "\ud83d\udc49", "\ud83e\udee5", "\ud83d\udc4a", "\u270a", "\ud83e\udd1c", "\ud83e\udd1b", "\ud83e\udd1d",
        "\u2764\ufe0f", "\ud83e\udde1", "\ud83d\udc9b", "\ud83d\udc9a", "\ud83d\udc99", "\ud83d\udc9c", "\u2666\ufe0f", "\u2661\ufe0f", "\ud83e\udde0", "\u2764\ufe0f\u200d\ud83e\ude79",
        "\ud83d\udcaf", "\ud83d\udca2", "\ud83d\udca5", "\ud83d\udcab", "\ud83d\udca6", "\ud83d\udca8", "\ud83d\udca7", "\ud83d\udcad", "\u2b50", "\ud83c\udf1f",
        "\ud83c\udf08", "\u2600\ufe0f", "\ud83c\udf24\ufe0f", "\u26c5", "\ud83c\udf25\ufe0f", "\ud83c\udf26\ufe0f", "\ud83c\udf27\ufe0f", "\u2600\ufe0f", "\ud83c\udf08", "\ud83c\udf0a",
        "\ud83c\udf0a", "\ud83c\udfb5", "\ud83c\udfb6", "\ud83c\udfa4", "\ud83c\udfb7", "\ud83c\udfba", "\ud83c\udfb8", "\ud83c\udfb9", "\ud83c\udfbb", "\ud83c\udfba"
    ]

    function fuzzyQuery(search) {
        if (search.trim() === "")
            return list.length > 0 ? list : defaultEmojis;

        const query = search.toLowerCase();
        return (list.length > 0 ? list : defaultEmojis).filter(function(emoji) {
            return emoji.toLowerCase().includes(query);
        });
    }

    function load() {
        emojiFileView.reload();
    }

    Component.onCompleted: {
        if (list.length === 0)
            list = defaultEmojis;
        load();
    }

    FileView {
        id: emojiFileView
        path: root.emojiFilePath

        onLoaded: function() {
            const lines = text().split("\n").filter(function(line) { return line.trim() !== ""; });
            if (lines.length > 0)
                root.list = lines.map(function(line) { return line.trim(); });
        }

        onLoadFailed: function() {
            // Use default emojis if file not found
        }
    }
}
