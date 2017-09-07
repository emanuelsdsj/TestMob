import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0

import "./AwesomeIcon/" as AwesomeIcon

Flickable {
    id: pageFlickable
    contentHeight: Math.max(content.implicitHeight, height)
    boundsBehavior: Flickable.DragOverBounds

    Column {
        id: content
        spacing: 25
        topPadding: 15
        width: parent.width * 0.90
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            color: "transparent"
            width: parent.width; height: parent.height * 0.40
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: brand
                anchors.centerIn: parent
                text: "CES"; color: "#333"
                font { pointSize: 22; weight: Font.Bold }
            }
        }

        TextField {
            id: email
            color: "#333"
            width: windowApp.width - (windowApp.width*0.15)
            selectByMouse: true
            inputMethodHints: Qt.ImhLowercaseOnly
            anchors.horizontalCenter: parent.horizontalCenter
            onAccepted: password.focus = true
            placeholderText: qsTr("Email")
            background: Rectangle {
                color: "#333"
                y: (email.height-height) - (email.bottomPadding / 2)
                width: email.width; height: email.activeFocus ? 2 : 1
                border { width: 1; color: "#333" }
            }
        }

        TextField {
            id: password
            color: "#333"
            width: windowApp.width - (windowApp.width*0.15)
            echoMode: TextInput.Password; font.letterSpacing: 1
            anchors.horizontalCenter: parent.horizontalCenter
            selectByMouse: true
            onAccepted: loginButton.clicked()
            inputMethodHints: Qt.ImhNoPredictiveText
            placeholderText: qsTr("Password")
            background: Rectangle {
                color: "#333"
                y: (password.height-height) - (password.bottomPadding / 2)
                width: password.width; height: password.activeFocus ? 2 : 1
                border { width: 1; color: "#333" }
            }
            AwesomeIcon.AwesomeIcon {
                z: parent.z + 10; size: 20
                name: password.echoMode == TextInput.Password ? "eye" : "eye_slash"; color: parent.color
                anchors { verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: 0 }
                onClicked: parent.echoMode = parent.echoMode == TextInput.Password ? TextInput.Normal : TextInput.Password
            }
        }

        Button {
            id: loginButton
            text: qsTr("LOG IN");
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                userLogIn();
            }
        }
    }
}
