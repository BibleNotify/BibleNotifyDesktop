import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    property var stackView
    property var setIntervalView

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
        }

        BNButton {
            id: changeIntervalButton
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Change Notification Interval")
            onClicked: root.StackView.view.push(setIntervalView)
        }

        Item {
            height: 24
        }
    }
}