import QtQuick
import QtQuick.Controls
// import QtGraphicalEffects

Item {
    id: root
    width: 64
    height: 64

    property real speed: 5
    property real health: 100
    property real shield: 0
    property bool isInvulnerable: false
    property bool isShooting: false
    property int powerLevel: 1

    // Movement properties
    property real xVelocity: 0
    property real yVelocity: 0
    property real maxSpeed: 10
    property real acceleration: 0.5
    property real deceleration: 0.2

    // Ship body
    Rectangle {
        id: shipBody
        anchors.fill: parent
        color: "#4CAF50"
        radius: width / 4

        // Ship details
        Rectangle {
            id: cockpit
            width: parent.width * 0.6
            height: parent.height * 0.4
            anchors.centerIn: parent
            color: "#81C784"
            radius: width / 2
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
            color: "#388E3C"
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
            color: "#388E3C"
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
            color: "#FFC107"
            radius: width / 2

            SequentialAnimation on opacity {
                running: true
                loops: Animation.Infinite
                NumberAnimation { to: 0.3; duration: 200 }
                NumberAnimation { to: 1.0; duration: 200 }
            }
        }
    }

    // Shield effect
    Rectangle {
        id: shield
        anchors.fill: parent
        radius: width / 2
        color: "transparent"
        border.width: 2
        border.color: "#2196F3"
        opacity: root.shield > 0 ? 0.5 : 0
        visible: root.shield > 0

        SequentialAnimation on scale {
            running: root.shield > 0
            loops: Animation.Infinite
            NumberAnimation { to: 1.1; duration: 1000 }
            NumberAnimation { to: 1.0; duration: 1000 }
        }
    }

    // Invulnerability effect
    Rectangle {
        id: invulnerabilityEffect
        anchors.fill: parent
        radius: width / 2
        color: "transparent"
        border.width: 2
        border.color: "#FFC107"
        opacity: root.isInvulnerable ? 0.5 : 0
        visible: root.isInvulnerable

        SequentialAnimation on opacity {
            running: root.isInvulnerable
            loops: Animation.Infinite
            NumberAnimation { to: 0.2; duration: 200 }
            NumberAnimation { to: 0.8; duration: 200 }
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
        if (isInvulnerable) return

        if (shield > 0) {
            shield = Math.max(0, shield - amount)
        } else {
            health = Math.max(0, health - amount)
            isInvulnerable = true
            invulnerabilityTimer.start()
        }
    }

    function addShield(amount) {
        shield = Math.min(100, shield + amount)
    }

    function addHealth(amount) {
        health = Math.min(100, health + amount)
    }

    function upgradePower() {
        powerLevel = Math.min(3, powerLevel + 1)
    }

    // Timers
    Timer {
        id: invulnerabilityTimer
        interval: 2000
        onTriggered: root.isInvulnerable = false
    }

    // Key handling
    Keys.onPressed: function(event) {
        switch(event.key) {
            case Qt.Key_Left:
            case Qt.Key_A:
                xVelocity = -maxSpeed
                break
            case Qt.Key_Right:
            case Qt.Key_D:
                xVelocity = maxSpeed
                break
            case Qt.Key_Up:
            case Qt.Key_W:
                yVelocity = -maxSpeed
                break
            case Qt.Key_Down:
            case Qt.Key_S:
                yVelocity = maxSpeed
                break
            case Qt.Key_Space:
                isShooting = true
                break
        }
    }

    Keys.onReleased: function(event) {
        switch(event.key) {
            case Qt.Key_Left:
            case Qt.Key_A:
                if (xVelocity < 0) xVelocity = 0
                break
            case Qt.Key_Right:
            case Qt.Key_D:
                if (xVelocity > 0) xVelocity = 0
                break
            case Qt.Key_Up:
            case Qt.Key_W:
                if (yVelocity < 0) yVelocity = 0
                break
            case Qt.Key_Down:
            case Qt.Key_S:
                if (yVelocity > 0) yVelocity = 0
                break
            case Qt.Key_Space:
                isShooting = false
                break
        }
    }

    // Movement update
    Timer {
        running: true
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
}
