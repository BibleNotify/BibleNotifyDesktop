import QtQuick
import QtQuick.Controls


ScrollBar {
    id: root
    visible: policy === ScrollBar.AlwaysOn

    property real thickness: 8
    property real minSize: 30

    property var containerItem: root.parent

    minimumSize: minSize / height

    background: Rectangle {}

    contentItem: Rectangle {
        implicitWidth: root.thickness
        implicitHeight: root.thickness
        radius: root.thickness / 2
        color: root.pressed ? "#81e889" : "#c2f4c6"
    }
}
