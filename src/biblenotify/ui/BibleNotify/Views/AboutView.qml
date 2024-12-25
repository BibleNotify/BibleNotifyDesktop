import QtQuick
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/illustration.svg"
            antialiasing: true
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
            font.bold: true
            text: qsTr("Bible Notify Desktop v0.1")
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin - 30 // Is this a hack?
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 14
            text: qsTr("Bible Notify is free and open-source software, provided freely for the edification of believers")
            color: "#494949"
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 14
            font.italic: true
            text: qsTr("Licensed under the GPL-3.0 license")
            color: "#494949"
        }

        Item {
            height: 5
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
            // TODO: Style the link
            text: "<a href='https://biblenotify.github.io'>https://biblenotify.github.io</a>"
            font.pixelSize: 16
            font.bold: true
            onLinkActivated: Qt.openUrlExternally("https://biblenotify.github.io")
            // TODO: Should this be a MouseArea?
            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }
        }

        Item {
            height: 10
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 11
            color: "#7E7E7E"
            text: qsTr("Bible Notify Desktop © 2024 Bible Notify Contributors")
        }
    }
}
