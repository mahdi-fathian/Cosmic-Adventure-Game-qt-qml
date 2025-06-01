import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: root
    width: 32
    height: 32

    property int type: 0 // 0: Shield, 1: Health, 2: Power
    property bool isActive: true
    property real xVelocity: 0
    property real yVelocity: 0

    // Power-up body
    Rectangle {
        id: powerUpBody
        anchors.fill: parent
        color: type === 0 ? "#2196F3" : type === 1 ? "#4CAF50" : "#FFC107"
        radius: width / 2

        // Inner circle
        Rectangle {
            id: innerCircle
            width: parent.width * 0.6
            height: parent.height * 0.6
            anchors.centerIn: parent
            color: type === 0 ? "#64B5F6" : type === 1 ? "#81C784" : "#FFD54F"
            radius: width / 2

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                color: innerCircle.color
                radius: 8
                samples: 17
                transparentBorder: true
            }
        }

        // Icon
        Text {
            id: icon
            anchors.centerIn: parent
            text: type === 0 ? "S" : type === 1 ? "H" : "P"
            color: "white"
            font.pixelSize: parent.width * 0.5
            font.bold: true
        }
    }

    // Floating animation
    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        NumberAnimation {
            target: root
            property: "y"
            to: root.y - 10
            duration: 1000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            property: "y"
            to: root.y + 10
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }

    // Rotation animation
    RotationAnimation {
        target: powerUpBody
        running: true
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 3000
    }

    // Movement behavior
    Behavior on x {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
    }

    Behavior on y {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
    }

    // Functions
    function setType(newType) {
        type = newType
    }

    function collect() {
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