import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import BibleNotify.UiComponents


ApplicationWindow {
    id: root
    visible: true
    flags: Qt.FramelessWindowHint
    width: 960
    height: 600

    Page {
        anchors.fill: parent

        header: ToolBar {
            contentHeight: 58

            background: Rectangle {
                height: parent.height
                color: "#EFEFEF"
            }

            Item {
                anchors.fill: parent

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
                    height: parent.height
                    spacing: 4
                    // TODO: Make a new component named "BNLabel"
                    Label {
                        font.pixelSize: 20
                        text: qsTr("Bible Notify")
                    }
                }

                RowLayout {
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    height: parent.height
                    spacing: 0

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
        }

        Rectangle {
            anchors.fill: parent
            color: "#FFFFFF"
        }

        ColumnLayout {
            anchors.fill: parent

            Image {
                Layout.alignment: Qt.AlignHCenter
                source: "qrc:/illustration.svg"
                antialiasing: true
            }

            Label {
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 60
                font.bold: true
                text: qsTr("Bible Notify")
            }

            Label {
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 12
                text: qsTr("DAILY BIBLE VERSE NOTIFICATION APP")
            }

            BNButton {
                id: startNotificationsButton
                Layout.alignment: Qt.AlignHCenter
                isAccented: true
                text: qsTr("Start Sending Notifications")
                icon: "info-circle"
            }

            BNButton {
                id: changeIntervalButton
                Layout.alignment: Qt.AlignHCenter
                text: qsTr("Change Notification Interval")
            }
        }
    }
}
