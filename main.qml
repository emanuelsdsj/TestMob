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
    property QtObject menuDrawer
    property bool isLoggedIn: false
    onDepthChanged: depth === 1 ? mainPages = 1 : mainPages = 0

    function pushPage(url, args) {
        pageStack.push(url, args)
    }

    function popPage() {
        pageStack.pop()
    }

    function userLogIn() {
        isLoggedIn = !isLoggedIn;
    }

    header: ToolBar {
        id: toolbar1
        visible: isLoggedIn
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
                onClicked: mainPages == 1 ? menuDrawer.open() : popPage()
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

    Loader {
        id: menuLoader
        asynchronous: true
        active: isLoggedIn; source: "qrc:/Menu.qml"
        onLoaded: {
            windowApp.menuDrawer = item;
        }
    }

    StackView {
        id: pageStack
        initialItem: "qrc:/Login.qml"
        focus: true; anchors.fill: parent
        onCurrentItemChanged: menuDrawer ? menuDrawer.close() : 0

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
