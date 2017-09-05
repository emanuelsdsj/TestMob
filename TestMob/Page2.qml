import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

Page {
    title: "page2"
    objectName: "page2"
    Label {
        visible: true
        text: "Page2"
        anchors.centerIn: parent
        MouseArea {
            anchors.fill: parent
            onClicked: pushPage("qrc:/Page3.qml");
        }
    }
}
