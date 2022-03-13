import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Item {
    id: root

    ColumnLayout {
        anchors.fill: parent

        Item {
            height: 20
        }

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 18
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Change when the daily<br>notification is sent:")
        }

        Item {
            height: 20
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            BNTumbler {
                id: hoursTumbler
                model: {
                    var hours = []
                    for (var i = 1; i < 13; i++) {
                        hours.push(i)
                    }
                    return hours
                }
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

        Item {
            height: 60
        }

        BNButton {
            id: setTimeButton
            Layout.alignment: Qt.AlignHCenter
            isAccented: true
            text: qsTr("Set Notification Time")
            onClicked: {
                Notifications.setNotificationTime(hoursTumbler.currentIndex + 1, minutesTumbler.currentIndex, amPmTumbler.model[amPmTumbler.currentIndex])
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