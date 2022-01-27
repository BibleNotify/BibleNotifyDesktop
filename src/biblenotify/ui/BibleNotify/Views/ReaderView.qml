import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    property string chapterLocation: ""

    ColumnLayout {
        anchors.fill: parent

        BNLabel {
            text: Notifications.loadChapter(root.chapterLocation)
        }
    }
}