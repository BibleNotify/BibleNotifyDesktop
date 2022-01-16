import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    ColumnLayout {
        anchors.fill: parent

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 20
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Change when the daily<br>notification is sent:")
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            BNTumbler {
                id: hoursTumbler
                model: 12
            }

            BNLabel {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: ":"
            }

            BNTumbler {
                id: minutesTumbler
                model: 60
            }

            BNTumbler {
                id: amPmTumbler
                model: ["AM", "PM"]
            }
        }

        BNButton {
            id: setIntervalButton
            Layout.alignment: Qt.AlignHCenter
            isAccented: true
            text: qsTr("Set Notification Interval")
            onClicked: {
                // TODO: Set the notification interval
                Notifications.printHello()
                root.StackView.view.pop()
            }
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