import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    implicitWidth: 308
    implicitHeight: 58

    property alias text: label.text
    property alias radius: background.radius
    property bool isAccented: false
    property bool hovered: false

    signal clicked()
    // signal hoveredChanged()

    property int borderNormalWidth: 2
    property int borderAccentWidth: 0
    property int borderDisabledWidth: 0

    // TODO: Make a nicer normal state hover look
    property string borderNormalColor: "#242424"
    property string borderAccentColor: "#242424"
    property string borderDisabledColor: "#242424"

    property string backgroundNormalColor: "#FFFFFF"
    property string backgroundAccentColor: "#7DD273"
    property string backgroundDisabledColor: "#FFFFFF"

    property string textNormalColor: "#000000"
    property string textAccentColor: "#FFFFFF"
    property string textDisabledColor: "#444444"

    property string icon: ""
    property int iconWidth: 24
    property int iconHeight: 24

    Rectangle {
        id: background
        anchors.fill: parent
        color: {
            if (root.enabled) {
                return (root.isAccented ? root.backgroundAccentColor : root.backgroundNormalColor)
            } else {
                return root.backgroundDisabledColor
            }
        }

        border.width: {
            if (root.enabled) {
                return (root.isAccented ? root.borderAccentWidth : root.borderNormalWidth)
            } else {
                return root.borderDisabledWidth
            }
        }

        opacity: root.hovered ? 0.6 : 1
        radius: root.height / 2
    }

    RowLayout {
        anchors.fill: parent
        Label {
            id: label
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("")
            font.family: "Roboto"
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: {
                if (root.enabled){
                    return (root.isAccented ? root.textAccentColor : root.textNormalColor)
                } else {
                    return root.textDisabledColor
                }
            }
        }

        BNIcon {
            visible: root.icon !== ""
            icon: root.icon
            //color: label.color
            width: root.iconWidth
            height: root.iconHeight
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
        onHoveredChanged: {
            root.hovered = !root.hovered
            root.hoveredChanged()
        }
    }
}

