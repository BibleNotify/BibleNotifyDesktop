import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    property var setTimeView
    property string verseText
    property string verseReference

    signal sendNotification

    ColumnLayout {
        anchors.fill: parent

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter

            BNLabel {
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 600
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 30
                color: "#24292f"
                text: qsTr(verseText)
            }

            Item {
                height: 10
            }

            BNLabel {
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: root.width - root.anchors.leftMargin - root.anchors.rightMargin
                horizontalAlignment: Text.AlignHCenter
                font { pixelSize: 20; italic: true; }
                color: "#616161"
                text: qsTr(verseReference)
            }
        }

        Item {
            height: 10
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter

            BNButton {
                id: toggleNotificationsButton
                Layout.alignment: Qt.AlignHCenter
                isAccented: true
                text: toggleNotificationsButton.toggled ? qsTr("Stop Sending Notifications") : qsTr("Start Sending Notifications")
                icon: toggleNotificationsButton.toggled ? "pause-circle" : "play-circle"
                onClicked: Notifications.setNotificationsEnabled(toggled)
            }

            BNButton {
                id: changeTimeButton
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("Change Notification Time")
                onClicked: root.StackView.view.push(setTimeView)
            }
        }


        Item {
            height: 24
        }
    }

    Timer {
        id: notificationTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (Notifications.isNotificationTime() === true) {
                if (Notifications.getNotificationsEnabled() === true) {
                    root.sendNotification()
                }
            }
        }
    }
}