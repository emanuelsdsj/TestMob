import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "./AwesomeIcon/" as AwesomeIcon

Pane {
    anchors.fill: parent
    property alias tabBarChild: tabBar
    property alias swipeChild: swipe
    property alias swipeChildCurrentItem: swipe.currentItem
    SwipeView {
        id: swipe
        visible: isUserLoggedIn
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {

        }
        Page2 {

        }
    }


    TabBar {
        id: tabBar
        visible: swipe.visible
        currentIndex: swipe.currentIndex
        z: swipe.z

        Repeater {
            model: listModel
            TabButton {
                height: 35
                Rectangle {anchors.fill: parent; color: Qt.rgba(0, 0, 255, 0.3)}

                ColumnLayout {
                    spacing: 0; height: parent.height
                    anchors.centerIn: parent

                    AwesomeIcon.AwesomeIcon {
                        id: icon1
                        size: 10
                        color: "black"
                        name: iconText
                        clickEnabled: false
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: name
                        color: icon1.color
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }

    ListModel {
        id: listModel
        ListElement { name: "Page1"; iconText: "cut"}
        ListElement { name: "Page2"; iconText: "paperclip"}
    }


}
