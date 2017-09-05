import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick 2.7

import "./AwesomeIcon/" as AwesomeIcon

ApplicationWindow {
    id: windowApp
    width: 480
    height: 640
    visible: true

    property alias currentPage: pageStack.currentItem
    property alias depth: pageStack.depth
    property int mainPages: 1
    onDepthChanged: depth === 1 ? mainPages = 1 : mainPages = 0

    function pushPage(url, args) {
        pageStack.push(url, args)
    }

    function popPage() {
        pageStack.pop()
    }

    header: ToolBar {
        RowLayout {
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.fill: parent

            AwesomeIcon.AwesomeIcon {
                name: mainPages == 1 ? "cog" :"commenting"; color: "black"
                onClicked: mainPages == 1 ? drawer.open() : popPage()
            }
            Label {
                text: currentPage.objectName
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                text: qsTr("⋮")
                onClicked: menu.open()
            }
        }
    }

    Drawer {
        id: drawer
        width: windowApp.width/2
        height: windowApp.height
        interactive: depth === 1 ? true : false
        Rectangle{
            Column{
                spacing: 5
                Rectangle {
                    height: label.height
                    width: label.width
                    Label {
                        id: label
                        text:"Awesome"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: pageStack.replace("qrc:/Page1.qml")
                    }
                }
                Rectangle {
                    height: label.height
                    width: label.width
                    Label {
                        id: label2
                        text:"Awesome"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: pageStack.replace("qrc:/Page2.qml")
                    }
                }
            }
        }
    }

    StackView {
        id: pageStack
        initialItem: "qrc:/Page1.qml"
        focus: true; anchors.fill: parent
        onCurrentItemChanged: drawer.close()

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                if (pageStack.depth > 1) {
                    pageStack.pop();
                    event.accepted = true;
                }
            }
        }

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0; to: 1; duration: 450
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1; to: 0; duration: 450
            }
        }
    }
}
