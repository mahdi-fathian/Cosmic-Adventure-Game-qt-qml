import QtQuick

Rectangle {
    id: enemy
    width: 48
    height: 48
    color: "transparent"

    // Enemy properties
    property int type: 0 // 0: Basic, 1: Flying, 2: Shooting
    property real speed: 2
    property real health: 100
    property bool isActive: true
    property int damage: 10

    // Enemy sprite
    Image {
        id: enemySprite
        anchors.fill: parent
        source: type === 0 ? "qrc:/assets/images/enemy_basic.png" :
               type === 1 ? "qrc:/assets/images/enemy_flying.png" :
                          "qrc:/assets/images/enemy_shooting.png"
        fillMode: Image.PreserveAspectFit
    }

    // Movement patterns based on type
    SequentialAnimation {
        running: isActive
        loops: Animation.Infinite

        // Basic enemy: Move left and right
        NumberAnimation {
            target: enemy
            property: "x"
            to: x + (type === 0 ? 200 : 0)
            duration: 2000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: enemy
            property: "x"
            to: x - (type === 0 ? 200 : 0)
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        // Flying enemy: Move up and down
        NumberAnimation {
            target: enemy
            property: "y"
            to: y + (type === 1 ? 100 : 0)
            duration: 1500
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: enemy
            property: "y"
            to: y - (type === 1 ? 100 : 0)
            duration: 1500
            easing.type: Easing.InOutQuad
        }
    }

    // Shooting behavior for shooting enemies
    Timer {
        running: isActive && type === 2
        repeat: true
        interval: 2000
        onTriggered: {
            var bullet = bulletComponent.createObject(parent)
            bullet.x = enemy.x + enemy.width
            bullet.y = enemy.y + enemy.height/2
        }
    }

    // Bullet component for shooting enemies
    Component {
        id: bulletComponent
        Rectangle {
            width: 20
            height: 10
            color: "red"
            radius: 5

            Timer {
                running: true
                repeat: true
                interval: 16
                onTriggered: {
                    x += 5
                    if (x > parent.width) {
                        destroy()
                    }
                }
            }
        }
    }

    // Hit effect
    SequentialAnimation {
        id: hitAnimation
        running: false
        NumberAnimation {
            target: enemy
            property: "opacity"
            to: 0.5
            duration: 100
        }
        NumberAnimation {
            target: enemy
            property: "opacity"
            to: 1
            duration: 100
        }
    }

    // Take damage function
    function takeDamage(amount) {
        health -= amount
        hitAnimation.start()
        if (health <= 0) {
            isActive = false
            destroy()
        }
    }

    // Collision detection
    function checkCollision(other) {
        return isActive && 
               x < other.x + other.width &&
               x + width > other.x &&
               y < other.y + other.height &&
               y + height > other.y
    }
} 