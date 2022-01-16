import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    property var stackView
    property var setTimeView

    signal sendNotification

    ColumnLayout {
        anchors.fill: parent

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/illustration.svg"
            antialiasing: true
        }

        BNButton {
            id: toggleNotificationsButton
            Layout.alignment: Qt.AlignHCenter
            isAccented: true
            text: qsTr("Start Sending Notifications")
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
                }
            }
        }
    }
}