import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: root
    width: 8
    height: 32

    property bool isActive: true
    property real damage: 20
    property real speed: 10
    property bool isEnemy: false
    property real xVelocity: 0
    property real yVelocity: isEnemy ? speed : -speed

    // Laser body
    Rectangle {
        id: laserBody
        anchors.fill: parent
        color: isEnemy ? "#F44336" : "#2196F3"
        radius: width / 2

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: laserBody.color
            radius: 8
            samples: 17
            transparentBorder: true
        }
    }

    // Trail effect
    Rectangle {
        id: trail
        width: parent.width * 1.5
        height: parent.height * 0.5
        anchors {
            top: isEnemy ? parent.bottom : undefined
            bottom: isEnemy ? undefined : parent.top
            horizontalCenter: parent.horizontalCenter
        }
        color: isEnemy ? "#EF5350" : "#64B5F6"
        radius: width / 2
        opacity: 0.5

        // Trail animation
        SequentialAnimation on opacity {
            running: true
            loops: Animation.Infinite
            NumberAnimation { to: 0.2; duration: 100 }
            NumberAnimation { to: 0.5; duration: 100 }
        }
    }

    // Movement behavior
    Behavior on x {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
    }

    Behavior on y {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
    }

    // Functions
    function hit() {
        isActive = false
        destroy()
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
            if (y < -height || y > parent.height) {
                hit()
            }
        }
    }
} 