import QtQuick
import QtQuick.Controls


Tumbler {
    id: root

    Rectangle {
        anchors.horizontalCenter: root.horizontalCenter
        y: root.height * 0.4
        width: root.width * 0.8
        height: 2
        color: "#7DD273"
    }

    Rectangle {
        anchors.horizontalCenter: root.horizontalCenter
        y: root.height * 0.6
        width: root.width * 0.8
        height: 2
        color: "#7DD273"
    }
}
