import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "./AwesomeIcon/" as AwesomeIcon

ApplicationWindow {
    id: windowApp
    visible: true
    width: 640
    height: 480

    property int mainPages: 1
    property alias currentPage: pageStack.currentItem
    property alias currentPageSwipe: swipe.currentItem
    property alias depth: pageStack.depth
    property bool isUserLoggedIn: false
    onDepthChanged:  depthChange()
    onCurrentPageSwipeChanged: currentPageSwipe ? toolbarText.text = currentPageSwipe.objectName : ""
    onCurrentPageChanged: currentPage ? toolbarText.text = currentPage.objectName : ""
    function depthChange() {
        if(depth === 0){
            mainPages = 1
            tabBar.visible = true
            toolbarText.text = currentPageSwipe.objectName
            swipe.z = swipe.parent.z + 1
            pageStack.z = pageStack.parent.z - 1
        } else {
            mainPages = 0
            tabBar.visible = false
            pageStack.z = pageStack.parent.z + 1
            swipe.z = swipe.parent.z - 1
        }
    }

    function pushPage(url, args) {
        pageStack.push(url, args)
    }

    function popPage() {
        if(depth === 1)
            pageStack.clear()
        pageStack.pop()
    }

    function userLogIn() {
        pageStack.clear()
        isUserLoggedIn = !isUserLoggedIn
    }

    header: ToolBar {
        id: toolbar1
        visible: isUserLoggedIn
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0, 0, 255, 0.3)
        }
        anchors.leftMargin: 10

        RowLayout {
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.fill: parent

            AwesomeIcon.AwesomeIcon {
                name: mainPages == 1 ? "" :"arrow_left"; color: "black"
                size: 22
                onClicked: popPage()
            }
            Label {
                id: toolbarText
                text: currentPage !== null ? currentPage.objectName : currentPageSwipe.objectName
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                anchors.centerIn: parent
            }
        }
    }

    SwipeView {
        id: swipe
        visible: isUserLoggedIn
        anchors.fill: parent
        width: windowApp.width
        currentIndex: tabBar.currentIndex

        Page1 {

        }
        Page2 {

        }
    }

    footer: TabBar {
        id: tabBar
        visible: isUserLoggedIn
        currentIndex: swipe.currentIndex

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

    StackView {
        id: pageStack
        initialItem: "qrc:/Login.qml"
        //focus: true
        anchors.fill: parent

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
