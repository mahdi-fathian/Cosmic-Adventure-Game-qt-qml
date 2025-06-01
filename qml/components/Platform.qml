import QtQuick
import QtGraphicalEffects

Item {
    id: platform
    width: 120
    height: 20

    property bool isMoving: false
    property bool isBreaking: false
    property bool isBouncy: false
    property real bounceForce: 15

    // Platform body
    Rectangle {
        id: platformBody
        anchors.fill: parent
        color: isBouncy ? "#e74c3c" : "#2ecc71"
        radius: 5

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: platformBody.color
            radius: 8
            samples: 17
            transparentBorder: true
        }

        // Platform pattern
        Row {
            anchors.fill: parent
            spacing: 5
            Repeater {
                model: 6
                Rectangle {
                    width: (parent.width - 25) / 6
                    height: parent.height
                    color: Qt.lighter(platformBody.color, 1.2)
                    radius: 2
                }
            }
        }

        // Platform edges
        Rectangle {
            width: parent.width
            height: 2
            anchors.top: parent.top
            color: Qt.darker(platformBody.color, 1.2)
        }
        Rectangle {
            width: parent.width
            height: 2
            anchors.bottom: parent.bottom
            color: Qt.darker(platformBody.color, 1.2)
        }
    }

    // Movement animation
    SequentialAnimation {
        id: moveAnimation
        running: isMoving
        loops: Animation.Infinite
        NumberAnimation {
            target: platform
            property: "x"
            to: platform.x + 50
            duration: 2000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: platform
            property: "x"
            to: platform.x - 50
            duration: 2000
            easing.type: Easing.InOutQuad
        }
    }

    // Breaking animation
    SequentialAnimation {
        id: breakAnimation
        running: isBreaking
        NumberAnimation {
            target: platform
            property: "scale"
            to: 1.1
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: platform
            property: "opacity"
            to: 0
            duration: 200
            easing.type: Easing.InQuad
        }
        onFinished: platform.destroy()
    }

    // Bounce effect
    SequentialAnimation {
        id: bounceAnimation
        running: isBouncy
        loops: Animation.Infinite
        NumberAnimation {
            target: platform
            property: "scale"
            to: 1.05
            duration: 500
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: platform
            property: "scale"
            to: 1.0
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }

    // Particle effect for breaking
    ParticleSystem {
        id: particleSystem
        running: isBreaking

        Emitter {
            id: emitter
            anchors.fill: parent
            emitRate: 100
            lifeSpan: 500
            size: 8
            sizeVariation: 4
            velocity: AngleDirection {
                angle: 270
                angleVariation: 60
                magnitude: 100
                magnitudeVariation: 50
            }
        }

        ParticlePainter {
            delegate: Rectangle {
                width: 4
                height: 4
                radius: 2
                color: platformBody.color
                opacity: 0.8
            }
        }
    }

    // Collision detection
    function checkCollision(other) {
        return x < other.x + other.width &&
               x + width > other.x &&
               y < other.y + other.height &&
               y + height > other.y
    }

    // Break platform
    function break() {
        if (!isBreaking) {
            isBreaking = true
            breakAnimation.start()
        }
    }
} 