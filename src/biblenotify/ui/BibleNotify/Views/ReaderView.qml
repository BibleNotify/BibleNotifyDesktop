import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    property string chapterLocation: ""

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            implicitHeight: 38

            Row {
                anchors.left: parent.left
                spacing: 8

                BNButton {
                    id: homeButton
                    implicitWidth: 36
                    implicitHeight: 36
                    flat: true
                    icon: "house-door"
                    onClicked: root.StackView.view.pop()
                }
            }

            BNLabel {
                anchors.centerIn: parent
                text: qsTr(Notifications.loadChapter(root.chapterLocation)[1])
                color: "#242424"
                font.pixelSize: 18
                font.bold: true
            }

            BNButton {
                id: nextChapterButton
                anchors.right: parent.right
                implicitWidth: 36
                implicitHeight: 36
                flat: true
                icon: "shuffle"
                onClicked: {
                    var verse = Notifications.loadVerses()
                    root.chapterLocation = verse[2]
                }
            }
        }

        Rectangle {
            id: chapterBackground
            clip: true

            Layout.fillWidth: true
            Layout.fillHeight: true

            border.color: "#24242433"
            border.width: 1

            BNScrollView {
                id: scrollView
                
                anchors.fill: parent
                anchors.margins: 12

                contentWidth: chapterText.width
                contentHeight: chapterText.height

                BNLabel {
                    id: chapterText
                    width: chapterBackground.width - scrollView.ScrollBar.vertical.width - (scrollView.anchors.margins * 2)
                    textFormat: Text.RichText
                    text: qsTr(Notifications.loadChapter(root.chapterLocation)[0])
                }
            }
        }
    }
}