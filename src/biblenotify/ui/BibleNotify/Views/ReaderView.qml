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
                    // The following is taken directly from the docs
                    // ---------------------------------------------
                    // This is called an "unwind" operation, where the stack unwinds till the specified item. If the item is not found,
                    // stack unwinds until it is left with one item, which becomes the currentItem. To explicitly unwind to the bottom
                    // of the stack, it is recommended to use pop(null), although any non-existent item will do.
                    onClicked: root.StackView.view.pop(null)
                }
            }

            BNLabel {
                anchors.centerIn: parent
                text: Notifications.loadChapter(root.chapterLocation)["place"]
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
                    root.chapterLocation = verse["location"]
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
                    text: Notifications.loadChapter(root.chapterLocation)["text"]
                }
            }
        }
    }
}