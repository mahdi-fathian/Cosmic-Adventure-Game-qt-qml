import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: root
    width: 48
    height: 48

    property real health: 100
    property real speed: 3
    property int type: 0 // 0: Basic, 1: Fast, 2: Tank
    property bool isActive: true
    property real xVelocity: 0
    property real yVelocity: 0

    // Enemy body
    Rectangle {
        id: enemyBody
        anchors.fill: parent
        color: type === 0 ? "#F44336" : type === 1 ? "#FF9800" : "#9C27B0"
        radius: width / 4

        // Enemy details
        Rectangle {
            id: core
            width: parent.width * 0.6
            height: parent.height * 0.6
            anchors.centerIn: parent
            color: type === 0 ? "#EF5350" : type === 1 ? "#FFA726" : "#BA68C8"
            radius: width / 2

            // Core glow
            layer.enabled: true
            layer.effect: Glow {
                color: core.color
                radius: 8
                samples: 17
                transparentBorder: true
            }
        }

        // Wings
        Rectangle {
            id: leftWing
            width: parent.width * 0.8
            height: parent.height * 0.2
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            color: type === 0 ? "#D32F2F" : type === 1 ? "#F57C00" : "#7B1FA2"
            radius: height / 2
        }

        Rectangle {
            id: rightWing
            width: parent.width * 0.8
            height: parent.height * 0.2
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            color: type === 0 ? "#D32F2F" : type === 1 ? "#F57C00" : "#7B1FA2"
            radius: height / 2
        }

        // Engine glow
        Rectangle {
            id: engineGlow
            width: parent.width * 0.3
            height: parent.height * 0.4
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            color: type === 0 ? "#FF5252" : type === 1 ? "#FFB74D" : "#CE93D8"
            radius: width / 2

            SequentialAnimation on opacity {
                running: true
                loops: Animation.Infinite
                NumberAnimation { to: 0.3; duration: 200 }
                NumberAnimation { to: 1.0; duration: 200 }
            }
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
    function takeDamage(amount) {
        health = Math.max(0, health - amount)
        if (health <= 0) {
            isActive = false
            destroy()
        }
    }

    function setType(newType) {
        type = newType
        switch(type) {
            case 0: // Basic
                speed = 3
                health = 100
                break
            case 1: // Fast
                speed = 5
                health = 50
                break
            case 2: // Tank
                speed = 2
                health = 200
                break
        }
    }

    // Movement update
    Timer {
        running: isActive
        repeat: true
        interval: 16 // ~60 FPS
        onTriggered: {
            x += xVelocity
            y += yVelocity

            // Keep within bounds
            x = Math.max(0, Math.min(x, parent.width - width))
            y = Math.max(0, Math.min(y, parent.height - height))
        }
    }

    // Initialization
    Component.onCompleted: {
        setType(type)
    }
} 