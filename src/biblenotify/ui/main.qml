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
    width: 640
    height: 480

    Page {
        anchors.fill: parent
        anchors.margins: root.visibility === Window.windowed ? 5 : 0

        header: ToolBar {
            contentHeight: 48
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
                    spacing: 4
                    Label {
                        text: qsTr("Bible Notify")
                    }
                }

                RowLayout {
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    spacing: 0

                    ToolButton {
                        text: "X"
                        onClicked: {
                            root.close()
                            Qt.quit()
                        }
                    }
                }
            }
        }

        ColumnLayout {
            anchors.fill: parent
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
