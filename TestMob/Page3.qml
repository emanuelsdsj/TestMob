import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

Page {
    title: "page3"
    objectName: "page3"
    Label {
        visible: true
        text: "Page3"
        anchors.centerIn: parent
        MouseArea {
            anchors.fill: parent
            onClicked: pushPage("qrc:/Page4.qml");
        }
    }
}
