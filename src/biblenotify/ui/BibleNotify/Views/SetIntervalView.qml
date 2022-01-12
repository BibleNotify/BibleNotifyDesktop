import QtQuick
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
        }

        Item {
            height: 24
        }
    }
}