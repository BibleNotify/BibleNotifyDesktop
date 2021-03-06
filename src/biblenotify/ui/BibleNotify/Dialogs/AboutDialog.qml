import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import BibleNotify.UiComponents
import BibleNotify.Views


Window {
    id: root
    flags: Qt.Dialog | Qt.FramelessWindowHint
    width: 382
    height: 450
    color: "transparent"

    Rectangle {
        // TODO: Add a shadow
        id: dialogBackground
        anchors.fill: parent
        color: "#FFFFFF"
        radius: root.visibility === Window.Maximized ? 0 : 10
        // For now, add a subtle border
        border.width: 1
        border.color: "#eee"
    }

    Item {
        id: titleBar
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: 38

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
            color: "#F2F2F2"
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
            anchors.leftMargin: 20
            height: parent.height
            spacing: 8
            BNLabel {
                color: active ? "#000000" : "#848484"
                text: qsTr("About Bible Notify Desktop")
            }
        }

        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 20
            height: parent.height
            spacing: 8

            BNButton {
                id: quitButton
                implicitWidth: 26
                implicitHeight: 26
                flat: true
                icon: "x-lg"
                onClicked: root.close()
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: titleBar.height + 10
        anchors.bottomMargin: 20
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        initialItem: aboutView
    }

    AboutView {
        id: aboutView
    }
}
