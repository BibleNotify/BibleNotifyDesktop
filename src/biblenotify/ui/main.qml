import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Qt.labs.platform

import BibleNotify.Dialogs
import BibleNotify.UiComponents
import BibleNotify.Views


Window {
    id: root
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    width: 960
    height: 640
    color: "transparent"

    SystemTrayIcon {
        id: systemTray
        visible: true
        icon.source: "qrc:/icon.svg"

        menu: Menu {
            MenuItem {
                text: qsTr("Open Window")
                onTriggered: root.requestActivate()
            }

            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }

        onActivated: {
            root.show()
            root.raise()
        }

        onMessageClicked: {
            stackView.push(readerView)
        }
    }

    Rectangle {
        id: windowBackground
        anchors.fill: parent
        color: "#FFFFFF"
        radius: root.visibility === Window.Maximized ? 0 : 10
        // For now, add a subtle border
        border.width: 1
        border.color: "#eee"
    }

    Item {
        id: titleBar
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: 58

        Rectangle {
            anchors.fill: parent
            color: "#F2F2F2"
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
                id: readerViewButton
                implicitWidth: 36
                implicitHeight: 36
                flat: true
                icon: "book"
                onClicked: {
                    if (readerView.chapterLocation == "") {
                        var verse = Notifications.loadVerses()
                        readerView.chapterLocation = verse[2]
                    }
                    
                    stackView.push(readerView)
                }
            }

            BNButton {
                id: aboutButton
                implicitWidth: 36
                implicitHeight: 36
                flat: true
                icon: "info-circle"
                onClicked: aboutDialog.show()
            }

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
                    // This will quit the app completely, hence why it is commented out
                    // Qt.quit()
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: titleBar.height + 20
        anchors.bottomMargin: 50
        anchors.leftMargin: 50
        anchors.rightMargin: 50
        initialItem: homeView
    }

    HomeView {
        id: homeView
        setTimeView: setTimeView

        Component.onCompleted: {
            // TODO: Why doesn't this work?
            // Loader.printHello()
        }

        onSendNotification: {
            var verse = Notifications.loadVerses()
            readerView.chapterLocation = verse[2]
            systemTray.showMessage(verse[1], verse[0])
        }
    }

    ReaderView {
        id: readerView
        visible: false
        chapterLocation: ""
    }

    SetTimeView {
        id: setTimeView
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

    AboutDialog {
        id: aboutDialog
    }
}
