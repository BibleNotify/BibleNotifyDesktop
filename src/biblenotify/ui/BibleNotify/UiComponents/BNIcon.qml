import QtQuick
//import QtGraphicalEffects


Item {
    id: root

    implicitWidth: 48
    implicitHeight: 48

    property string icon
    //property alias color: overlay.color

    Image {
        anchors.fill: parent

        // TODO: Why does the icons appear sharp (not smooth)?
        antialiasing: true
        smooth: true

        source: "qrc:/icons/" + root.icon + ".svg"

        /*ColorOverlay {
            id: overlay
            anchors.fill: parent
            source: parent
        }*/
    }
}