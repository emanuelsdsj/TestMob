import QtQuick 2.8
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Material.impl 2.1

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
