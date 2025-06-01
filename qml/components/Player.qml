import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: player
    width: 64
    height: 64

    // Properties
    property real velocityX: 0
    property real velocityY: 0
    property real gravity: 0.5
    property bool isJumping: false
    property bool isMovingLeft: false
    property bool isMovingRight: false
    property bool isFacingRight: true
    property int lives: 3
    property bool isInvincible: false

    // Main player sprite
    Rectangle {
        id: playerBody
        anchors.fill: parent
        color: "#4a90e2"
        radius: width / 2

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: "#4a90e2"
            radius: 8
            samples: 17
            transparentBorder: true
        }

        // Helmet
        Rectangle {
            width: parent.width * 0.8
            height: parent.height * 0.4
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            radius: width / 2
            color: "#ffffff"
            opacity: 0.8

            // Helmet reflection
            Rectangle {
                width: parent.width * 0.3
                height: parent.height * 0.3
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 5
                radius: width / 2
                color: "#ffffff"
                opacity: 0.5
            }
        }

        // Eyes
        Row {
            anchors.centerIn: parent
            spacing: parent.width * 0.2

            Rectangle {
                width: parent.parent.width * 0.15
                height: width
                radius: width / 2
                color: "#000000"

                // Eye shine
                Rectangle {
                    width: parent.width * 0.4
                    height: width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 2
                    radius: width / 2
                    color: "#ffffff"
                }
            }

            Rectangle {
                width: parent.parent.width * 0.15
                height: width
                radius: width / 2
                color: "#000000"

                // Eye shine
                Rectangle {
                    width: parent.width * 0.4
                    height: width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 2
                    radius: width / 2
                    color: "#ffffff"
                }
            }
        }

        // Jetpack
        Rectangle {
            width: parent.width * 0.3
            height: parent.height * 0.4
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 5
            color: "#e74c3c"
            radius: 5

            // Jetpack flames
            Rectangle {
                id: jetpackFlame
                width: parent.width * 0.8
                height: parent.height * 0.6
                anchors.top: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#f1c40f"
                radius: width / 2

                // Flame animation
                SequentialAnimation {
                    running: isJumping
                    loops: Animation.Infinite
                    NumberAnimation {
                        target: jetpackFlame
                        property: "height"
                        to: jetpackFlame.height * 1.5
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: jetpackFlame
                        property: "height"
                        to: jetpackFlame.height / 1.5
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    // Movement animations
    SequentialAnimation {
        id: jumpAnimation
        running: isJumping
        NumberAnimation {
            target: player
            property: "scale"
            to: 1.2
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: player
            property: "scale"
            to: 1.0
            duration: 200
            easing.type: Easing.InQuad
        }
    }

    // Damage animation
    SequentialAnimation {
        id: damageAnimation
        running: isInvincible
        loops: 3
        NumberAnimation {
            target: player
            property: "opacity"
            to: 0.3
            duration: 200
        }
        NumberAnimation {
            target: player
            property: "opacity"
            to: 1.0
            duration: 200
        }
    }

    // Movement logic
    Timer {
        running: true
        repeat: true
        interval: 16
        onTriggered: {
            // Horizontal movement
            if (isMovingLeft) {
                velocityX = -5
                isFacingRight = false
                player.scale.x = -1
            } else if (isMovingRight) {
                velocityX = 5
                isFacingRight = true
                player.scale.x = 1
            } else {
                velocityX = 0
            }

            // Apply gravity
            velocityY += gravity
            y += velocityY

            // Jump logic
            if (isJumping && velocityY > 0) {
                isJumping = false
            }
        }
    }

    // Keyboard controls
    Keys.onLeftPressed: isMovingLeft = true
    Keys.onRightPressed: isMovingRight = true
    Keys.onReleased: function(event) {
        if (event.key === Qt.Key_Left) isMovingLeft = false
        if (event.key === Qt.Key_Right) isMovingRight = false
    }
    Keys.onSpacePressed: {
        if (!isJumping) {
            velocityY = -15
            isJumping = true
            jumpAnimation.start()
        }
    }

    // Collision detection
    function checkCollision(other) {
        return x < other.x + other.width &&
               x + width > other.x &&
               y < other.y + other.height &&
               y + height > other.y
    }

    // Take damage
    function takeDamage() {
        if (!isInvincible) {
            lives--
            isInvincible = true
            damageAnimation.start()
            Timer {
                interval: 1000
                running: true
                onTriggered: player.isInvincible = false
            }
        }
    }
} 