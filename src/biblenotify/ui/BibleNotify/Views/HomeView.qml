import QtQuick
import QtQuick.Layouts

import BibleNotify.UiComponents


ColumnLayout {
    id: homeView

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
    }

    BNButton {
        id: changeIntervalButton
        Layout.alignment: Qt.AlignHCenter
        text: qsTr("Change Notification Interval")
    }

    Item {
        height: 24
    }
}