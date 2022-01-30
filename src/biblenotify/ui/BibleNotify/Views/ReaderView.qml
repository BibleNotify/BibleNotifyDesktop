import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    property string chapterLocation: ""

    // TODO: Spacing is a little off
    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            implicitHeight: 58

            Row {
                anchors.left: parent.left
                spacing: 8

                BNButton {
                    id: previousChapterButton
                    implicitWidth: 36
                    implicitHeight: 36
                    flat: true
                    icon: "arrow-left-square"
                }

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
            }

            BNButton {
                id: nextChapterButton
                anchors.right: parent.right
                implicitWidth: 36
                implicitHeight: 36
                flat: true
                icon: "arrow-right-square"
            }
        }

        Rectangle {
            id: chapterBackground
            clip: true

            Layout.fillWidth: true
            Layout.fillHeight: true

            border.color: "#24242433"
            border.width: 1

            Flickable {
                id: scrollView
                anchors.fill: parent
                contentWidth: chapterText.width
                contentHeight: chapterText.height

                BNLabel {
                    id: chapterText
                    width: chapterBackground.width
                    textFormat: Text.RichText
                    text: qsTr(Notifications.loadChapter(root.chapterLocation)[0])
                }
            }
        }
    }
}