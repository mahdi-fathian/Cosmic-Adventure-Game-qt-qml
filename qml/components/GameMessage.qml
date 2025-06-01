import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    anchors.fill: parent

    // Properties
    property string message: ""
    property color messageColor: "#ffffff"
    property bool isActive: false

    // Message container
    Rectangle {
        id: messageContainer
        anchors.centerIn: parent
        width: messageText.width + 40
        height: messageText.height + 20
        color: "#1A000000"
        radius: 10
        visible: root.isActive

        // Blur effect
        MultiEffect {
            anchors.fill: parent
            source: parent
            blurEnabled: true
            blurMax: 8
            blur: 8
        }

        // Message text
        Text {
            id: messageText
            anchors.centerIn: parent
            text: root.message
            color: root.messageColor
            font.pixelSize: 32
            font.bold: true
            style: Text.Outline
            styleColor: "#000000"

            // Glow effect
            MultiEffect {
                anchors.fill: parent
                source: parent
                blurEnabled: true
                blurMax: 8
                blur: 8
                colorization: 1.0
                colorizationColor: root.messageColor
            }
        }

        // Entrance animation
        SequentialAnimation {
            id: entranceAnimation
            running: root.isActive
            NumberAnimation {
                target: messageContainer
                property: "scale"
                from: 0.0
                to: 1.0
                duration: 300
                easing.type: Easing.OutBack
            }
        }

        // Exit animation
        SequentialAnimation {
            id: exitAnimation
            running: !root.isActive
            NumberAnimation {
                target: messageContainer
                property: "scale"
                from: 1.0
                to: 0.0
                duration: 300
                easing.type: Easing.InBack
            }
            ScriptAction {
                script: root.destroy()
            }
        }
    }

    // Auto-hide timer
    Timer {
        id: autoHideTimer
        interval: 2000
        running: root.isActive
        onTriggered: root.isActive = false
    }

    // Auto-destroy timer
    Timer {
        id: autoDestroyTimer
        interval: 500
        running: !root.isActive
        onTriggered: root.destroy()
    }

    // Functions
    function showMessage(text, color, duration) {
        root.message = text
        root.messageColor = color || "#ffffff"
        root.isActive = true
        autoHideTimer.interval = duration || 2000
    }

    // Initialize
    Component.onCompleted: {
        if (root.message !== "") {
            root.isActive = true
        }
    }
} 