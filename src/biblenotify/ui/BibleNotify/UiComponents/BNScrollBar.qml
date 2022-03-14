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
        color: {
            if (root.pressed) {
                return "#7DD273"
            } else if (root.hovered) {
                return "#E5E5E5"
            } else {
                // Normal state
                return "#CCCCCC"
            }
        }
    }
}
