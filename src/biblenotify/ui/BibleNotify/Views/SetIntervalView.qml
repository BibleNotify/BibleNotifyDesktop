import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    ColumnLayout {
        anchors.fill: parent

        // TODO: Add time picker here

        BNButton {
            id: setIntervalButton
            Layout.alignment: Qt.AlignHCenter
            isAccented: true
            text: qsTr("Set Notification Interval")
        }

        BNButton {
            id: cancelButton
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Cancel")
            onClicked: root.StackView.view.pop()
        }

        Item {
            height: 24
        }
    }
}