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
    property bool toggled: false

    signal clicked()

    property int borderNormalWidth: 2
    property int borderAccentWidth: 0
    property int borderDisabledWidth: 0

    property string borderNormalColor: "#242424"
    property string borderAccentColor: "#242424"
    property string borderDisabledColor: "#242424"

    property string backgroundNormalColor: "#FFFFFF"
    property string backgroundNormalHoverColor: "#242424"
    property string backgroundAccentColor: "#7DD273"
    property string backgroundDisabledColor: "#FFFFFF"

    property string textNormalColor: "#000000"
    property string textNormalHoverColor: "#FFFFFF"
    property string textAccentColor: "#FFFFFF"
    property string textDisabledColor: "#444444"

    property string icon: ""
    property int iconWidth: 24
    property int iconHeight: 24

    Rectangle {
        id: background
        anchors.fill: parent
        color: {
            if (root.enabled && root.hovered && !root.isAccented) {
                return backgroundNormalHoverColor
            } else if (root.enabled) {
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

        opacity: {
            if (root.hovered) {
                if (root.isAccented) {
                    return 0.6
                } else {
                    return 1
                }
            } else {
                return 1
            }
        }
        radius: root.height / 2
    }

    Item {
        anchors.fill: parent
        Row {
            anchors.centerIn: parent
            spacing: 8

            Label {
                id: label
                text: qsTr("")
                font.family: "Roboto"
                font.pointSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: {
                    if (root.enabled && root.hovered && !root.isAccented) {
                        return textNormalHoverColor
                    } else if (root.enabled){
                        return (root.isAccented ? root.textAccentColor : root.textNormalColor)
                    } else {
                        return root.textDisabledColor
                    }
                }
            }

            BNIcon {
                id: icon
                visible: root.icon !== ""
                icon: root.icon
                //color: label.color
                width: root.iconWidth
                height: root.iconHeight
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.toggled = !root.toggled
            root.clicked()
        }
        onHoveredChanged: {
            root.hovered = !root.hovered
            root.hoveredChanged()
        }
    }
}

