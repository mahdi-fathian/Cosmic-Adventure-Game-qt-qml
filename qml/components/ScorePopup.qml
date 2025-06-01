import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: root
    width: 100
    height: 40

    property int score: 0
    property bool isActive: true
    property real xVelocity: 0
    property real yVelocity: -2

    // Score text
    Text {
        id: scoreText
        anchors.centerIn: parent
        text: "+" + score
        color: "#FFC107"
        font.pixelSize: 24
        font.bold: true

        // Text outline
        layer.enabled: true
        layer.effect: Glow {
            color: "#FFA000"
            radius: 8
            samples: 17
            transparentBorder: true
        }
    }

    // Movement behavior
    Behavior on x {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
    }

    Behavior on y {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
    }

    // Popup animation
    SequentialAnimation {
        running: true
        NumberAnimation {
            target: root
            property: "scale"
            from: 0.5
            to: 1.2
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: root
            property: "scale"
            to: 1.0
            duration: 100
            easing.type: Easing.InQuad
        }
        NumberAnimation {
            target: root
            property: "opacity"
            to: 0
            duration: 500
            easing.type: Easing.InQuad
        }
        onFinished: root.destroy()
    }

    // Functions
    function showScore(value) {
        score = value
    }

    // Movement update
    Timer {
        running: isActive
        repeat: true
        interval: 16 // ~60 FPS
        onTriggered: {
            x += xVelocity
            y += yVelocity

            // Destroy if out of bounds
            if (y < -height) {
                isActive = false
                destroy()
            }
        }
    }

    // Initialization
    Component.onCompleted: {
        showScore(score)
    }
} 