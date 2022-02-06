import QtQuick
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

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
            text: qsTr("Bible Notify Desktop v0.1")
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 11
            text: qsTr("Bible Notify is free and open-source software, provided freely for the edification of believers")
            color: "#494949"
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            text: qsTr("Licensed under the GPL-3.0 license")
            color: "#494949"
        }

        Row {
            spacing: 8
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin

            BNIcon {
                width: 20
                height: 20
                icon: "github"
            }

            BNLabel {
                text: qsTr("Source code is on GitHub")
            }
        }

        Row {
            spacing: 8
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin

            BNIcon {
                width: 20
                height: 20
                icon: "discord"
            }

            BNLabel {
                text: qsTr("Need help? Join our Discord")
            }
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 8
            text: qsTr("Bible Notify © 2022 Bible Notify Contributors")
        }
    }
}
