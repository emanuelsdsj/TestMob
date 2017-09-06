import QtQuick 2.8
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Material.impl 2.1

import "./AwesomeIcon/" as AwesomeIcon

ApplicationWindow {
    id: windowApp
    width: 340; height: 520; visible: true

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
        id: toolbar1
        Rectangle {
            anchors.fill: parent
            color: "#4d4dff"
        }
        anchors.leftMargin: 10

        RowLayout {
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.fill: parent

            AwesomeIcon.AwesomeIcon {
                name: mainPages == 1 ? "bars" :"arrow_left"; color: "black"
                size: 22
                onClicked: mainPages == 1 ? drawer.open() : popPage()
            }
            Label {
                text: currentPage.objectName
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                anchors.centerIn: parent
            }
        }
    }

    Drawer {
        id: drawer
        width: windowApp.width * 0.80
        height: windowApp.height
        interactive: depth === 1 ? true : false
        y: header.height

        ListView {
            id: listview
            width: parent.width; height: parent.height
            snapMode: ListView.SnapToItem
            clip: true

            model: listModel

            onMovementStarted: verticalScrollBar.opacity = 1
            onMovementEnded: verticalScrollBar.opacity = 0

            ScrollBar.vertical: ScrollBar {
                id: verticalScrollBar
                active: true
                orientation: Qt.Vertical

                opacity: 0
                Behavior on opacity {NumberAnimation { duration: 500 }}

                contentItem: Rectangle {
                    implicitWidth: 4
                    radius:2
                    implicitHeight: 100
                    color: "grey"
                }
            }

            delegate: Component {
                id: myDelegate
                Rectangle {
                    height: 50
                    width: drawer.width - 2
                    Label {
                        id: label
                        text: name
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: pageStack.replace(urlName)
                    }
                    Rectangle { width: parent.width; height: 1; color: "black"; opacity: 0.1; anchors.bottom: parent.bottom }
                }
            }
        }

        ListModel {
            id: listModel
            ListElement { name: "Page1"; urlName: "qrc:/Page1.qml"}
            ListElement { name: "Page2"; urlName: "qrc:/Page2.qml"}
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
