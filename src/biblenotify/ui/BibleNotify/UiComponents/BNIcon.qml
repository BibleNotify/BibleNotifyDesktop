import QtQuick
// import QtGraphicalEffects


Item {
    id: root

    width: 24
    height: 24

    property string icon

    // TODO: Add in the overlay color
    // property alias color: overlay.color

    Image {
        anchors.fill: parent

        antialiasing: true
        smooth: true
        sourceSize: Qt.size(root.width, root.height)

        source: "qrc:/icons/" + root.icon + ".svg"

        /*ColorOverlay {
            id: overlay
            anchors.fill: parent
            source: parent
        }*/
    }
}