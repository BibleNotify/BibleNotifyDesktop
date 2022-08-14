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

    property var resizeMargins: 8
    property var verse: Notifications.loadVerses()

    function focusWindow() {
        root.show()
        root.raise()
        root.requestActivate()
    }

    Item {
        id: leftResizeHandlerItem
        anchors.left: parent.left
        anchors.top: parent.top
        width: root.resizeMargins
        height: parent.height

        DragHandler {
            grabPermissions: DragHandler.CanTakeOverFromAnything
            onActiveChanged: {
                if (active) {
                    root.startSystemResize(Qt.LeftEdge);
                }
            }
        }

        HoverHandler {
            cursorShape: Qt.SizeHorCursor
        }
    }
    
    Item {
        id: rightResizeHandlerItem
        anchors.right: parent.right
        anchors.top: parent.top
        width: root.resizeMargins
        height: parent.height

        DragHandler {
            grabPermissions: DragHandler.CanTakeOverFromAnything
            onActiveChanged: {
                if (active) {
                    root.startSystemResize(Qt.RightEdge);
                }
            }
        }

        HoverHandler {
            cursorShape: Qt.SizeHorCursor
        }
    }

    Item {
        id: bottomResizeHandlerItem
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: parent.width
        height: root.resizeMargins

        DragHandler {
            grabPermissions: DragHandler.CanTakeOverFromAnything
            onActiveChanged: {
                if (active) {
                    root.startSystemResize(Qt.BottomEdge);
                }
            }
        }

        HoverHandler {
            cursorShape: Qt.SizeVerCursor
        }
    }

    SystemTrayIcon {
        id: systemTray
        visible: true
        icon.source: "qrc:/icon.svg"

        // TODO: Use custom system tray menu
        menu: Menu {
            MenuItem {
                text: qsTr("Open Window")
                onTriggered: root.focusWindow()
            }

            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }

        onMessageClicked: {
            root.focusWindow()
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
        
        Item {
            id: topResizeHandlerItem
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            height: root.resizeMargins

            DragHandler {
                grabPermissions: DragHandler.CanTakeOverFromAnything
                onActiveChanged: {
                    if (active) {
                        root.startSystemResize(Qt.TopEdge);
                    }
                }
            }

            HoverHandler {
                cursorShape: Qt.SizeVerCursor
            }
        }

        Item {
            anchors.left: parent.left
            anchors.leftMargin: root.resizeMargins
            width: parent.width - root.resizeMargins
            y: topResizeHandlerItem.y + topResizeHandlerItem.height
            height: parent.height - (topResizeHandlerItem.y + topResizeHandlerItem.height)
            DragHandler {
                grabPermissions: DragHandler.CanTakeOverFromAnything
                onActiveChanged: {
                    if (active) {
                        root.startSystemMove();
                    }
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
                        readerView.chapterLocation = root.verse["location"]
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
        verseText: root.verse["text"]
        verseReference: root.verse["place"]

        onSendNotification: {
            root.verse = Notifications.loadVerses()
            readerView.chapterLocation = root.verse["location"]
            systemTray.showMessage(root.verse["place"], root.verse["text"])
        }

        Component.onCompleted: {
            // TODO: Why doesn't this work?
            // Loader.printHello()
        }
    }

    ReaderView {
        id: readerView
        visible: false
        chapterLocation: root.verse["location"]
    }

    SetTimeView {
        id: setTimeView
        visible: false
    }

    AboutDialog {
        id: aboutDialog
    }
}
