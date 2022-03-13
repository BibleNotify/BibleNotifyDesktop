import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    property var setTimeView

    signal sendNotification

    ColumnLayout {
        anchors.fill: parent

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/illustration-with_text.svg"
            antialiasing: true
        }

        Item {
            height: 20
        }

        BNButton {
            id: toggleNotificationsButton
            Layout.alignment: Qt.AlignHCenter
            isAccented: true
            text: toggleNotificationsButton.toggled ? qsTr("Stop Sending Notifications") : qsTr("Start Sending Notifications")
            icon: toggleNotificationsButton.toggled ? "play-circle" : "pause-circle"
            onClicked: Notifications.setNotificationsEnabled(toggled)
        }

        BNButton {
            id: changeTimeButton
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Change Notification Time")
            onClicked: root.StackView.view.push(setTimeView)
        }

        Item {
            height: 24
        }
    }

    Timer {
        id: notificationTimer
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            if (Notifications.isNotificationTime() === true) {
                if (Notifications.getNotificationsEnabled() === true) {
                    root.sendNotification()
                    notificationTimer.running = false
                }
            }
        }
    }
}