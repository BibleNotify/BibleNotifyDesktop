import QtQuick
// import QtGraphicalEffects


Item {
    id: root

    implicitWidth: 48
    implicitHeight: 48

    property string icon

    // TODO: Add in the overlay color
    // property alias color: overlay.color

    Image {
        anchors.fill: parent

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