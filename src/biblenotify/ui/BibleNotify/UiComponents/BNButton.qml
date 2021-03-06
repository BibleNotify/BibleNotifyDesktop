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
    property bool flat: false

    signal clicked()

    property int borderNormalWidth: 2
    property int borderAccentWidth: 0
    property int borderDisabledWidth: 0

    property string borderNormalColor: "#242424"
    property string borderAccentColor: "#242424"
    property string borderDisabledColor: "#242424"

    property string backgroundNormalColor: "#FFFFFF"
    property string backgroundNormalHoverColor: "#242424"
    property string backgroundFlatHoverColor: "#CCCCCC"
    property string backgroundAccentColor: "#7DD273"
    property string backgroundAccentHoverColor: "#66A75E"
    property string backgroundDisabledColor: "#FFFFFF"

    property string textNormalColor: "#000000"
    property string textNormalHoverColor: "#FFFFFF"
    property string textAccentColor: "#FFFFFF"
    property string textDisabledColor: "#444444"

    property string icon: ""
    property int iconWidth: 20
    property int iconHeight: 20

    Rectangle {
        id: background
        anchors.fill: parent
        color: {
            if (root.flat && !root.hovered) {
                return "transparent"
            } else if (root.flat && root.hovered && root.enabled) {
                return root.backgroundFlatHoverColor
            } else if (root.enabled && root.hovered && !root.isAccented) {
                return backgroundNormalHoverColor
            } else if (root.enabled && root.hovered && root.isAccented) {
                return backgroundAccentHoverColor
            } else if (root.enabled) {
                return (root.isAccented ? root.backgroundAccentColor : root.backgroundNormalColor)
            } else {
                if (root.flat) {
                    return "transparent"
                } else {
                    return root.backgroundDisabledColor
                }
            }
        }

        border.width: {
            if (root.flat) {
                return 0
            } else if (root.enabled) {
                return (root.isAccented ? root.borderAccentWidth : root.borderNormalWidth)
            } else {
                return root.borderDisabledWidth
            }
        }

        opacity: {
            if (root.hovered) {
                if (root.isAccented) {
                    return 1 // 0.6
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

            Loader {
                sourceComponent: {
                    if (root.icon !== "") {
                        return iconComponent
                    }
                }
            }
        }
    }

    Component {
        id: iconComponent
        BNIcon {
            id: icon
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

