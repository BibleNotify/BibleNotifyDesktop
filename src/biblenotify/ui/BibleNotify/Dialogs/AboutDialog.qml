import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents


Window {
    id: root
    flags: Qt.Dialog | Qt.FramelessWindowHint
    width: 300
    height: 400
    color: "transparent"

    Rectangle {
        // TODO: Add a shadow
        id: dialogBackground
        anchors.fill: parent
        color: "#FFFFFF"
        radius: root.visibility === Window.Maximized ? 0 : 10
    }

    Item {
        id: titleBar
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: 28

        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            onActiveChanged: {
                if (active) {
                    root.startSystemMove()
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "#EFEFEF"
            radius: dialogBackground.radius

            // Make the bottom of the title bar look like a straight line
            Rectangle {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                color: parent.color
                width: parent.radius
                height: parent.radius
            }

            Rectangle {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                color: parent.color
                width: parent.radius
                height: parent.radius
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.leftMargin: 30
            height: parent.height
            spacing: 8
            BNLabel {
                color: active ? "#000000" : "#848484"
                text: qsTr("About")
            }
        }
    }
}
