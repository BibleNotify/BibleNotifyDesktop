import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import BibleNotify.UiComponents
import BibleNotify.Views


Window {
    id: root
    visible: true
    flags: Qt.FramelessWindowHint
    width: 960
    height: 640
    color: "transparent"

    Rectangle {
        id: windowBackground
        anchors.fill: parent
        color: "#FFFFFF"
        radius: 10
    }

    Item {
        id: titleBar
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: 58

        Rectangle {
            anchors.fill: parent
            color: "#EFEFEF"
            radius: windowBackground.radius

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

        TapHandler {
            onTapped: {
                if (tapCount === 2) {
                    if (root.visibility === Window.Windowed) {
                        root.showMaximized()
                    } else if (root.visibility === Window.Maximized) {
                        root.showNormal()
                    }
                }
            }

            gesturePolicy: TapHandler.DragThreshold
        }

        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            onActiveChanged: {
                if (active) {
                    root.startSystemMove();
                }
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.leftMargin: 30
            height: parent.height
            spacing: 8
            BNLabel {
                color: active ? "#000000" : "#848484"
                text: qsTr("Bible Notify")
            }
        }

        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 30
            height: parent.height
            spacing: 8

            BNButton {
                id: minimizeButton
                implicitWidth: 36
                implicitHeight: 36
                flat: true
                icon: "dash-lg"
                onClicked: root.showMinimized()
            }

            BNButton {
                id: quitButton
                implicitWidth: 36
                implicitHeight: 36
                flat: true
                icon: "x-lg"
                onClicked: {
                    root.close()
                    Qt.quit()
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: titleBar.height
        anchors.bottomMargin: 24
        initialItem: homeView
    }

    HomeView {
        id: homeView
        setIntervalView: setIntervalView
    }

    SetIntervalView {
        id: setIntervalView
        visible: false
    }

    BNLabel {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        text: qsTr("Bible Notify © 2022 Bible Notify Contributors")
        font.pixelSize: 10
        color: "#757575"
    }
}
