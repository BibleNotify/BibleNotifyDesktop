import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import BibleNotify.UiComponents


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
            // TODO: Make a new component named "BNLabel"
            Label {
                font.pixelSize: 20
                text: qsTr("Bible Notify")
            }
        }

        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 30
            height: parent.height
            spacing: 8

            // TODO: Make ToolButton into a new component (DNToolButton)
            // TODO: Can we use DNButton and use a "flat" property?
            ToolButton {
                id: minimizeButton
                implicitWidth: 36
                implicitHeight: 36
                BNIcon {
                    anchors.centerIn: parent
                    icon: "dash-lg"
                    width: 28
                    height: 28
                }

                onClicked: root.showMinimized()
            }

            ToolButton {
                id: quitButton
                implicitWidth: 36
                implicitHeight: 36
                BNIcon {
                    anchors.centerIn: parent
                    icon: "x-lg"
                    width: 28
                    height: 28
                }

                onClicked: {
                    root.close()
                    Qt.quit()
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: titleBar.height
        anchors.bottomMargin: 24

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

        BNLabel {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Bible Notify (c) 2022 Bible Notify Contributors")
            font.pixelSize: 10
            color: "#757575"
        }
    }
}
