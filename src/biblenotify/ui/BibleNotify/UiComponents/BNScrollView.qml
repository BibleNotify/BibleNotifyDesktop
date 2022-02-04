import QtQuick
import QtQuick.Controls

import BibleNotify.UiComponents


Flickable {
    id: root

    boundsBehavior: Flickable.StopAtBounds

    // clip: true

    ScrollBar.vertical: BNScrollBar {
        containerItem: root
        policy: ScrollBar.AlwaysOn
    }

    /*ScrollBar.horizontal: BNScrollBar {
        containerItem: root
        policy: ScrollBar.AlwaysOff
    }*/
}
