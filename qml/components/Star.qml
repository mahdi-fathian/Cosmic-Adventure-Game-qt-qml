import QtQuick
import QtGraphicalEffects

Item {
    id: star
    width: 32
    height: 32

    property bool collected: false
    property int points: 100

    // Star body
    Rectangle {
        id: starBody
        anchors.fill: parent
        color: "#f1c40f"
        radius: width / 2

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: "#f1c40f"
            radius: 8
            samples: 17
            transparentBorder: true
        }

        // Star shape
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "#f1c40f"
                ctx.beginPath()
                
                // Draw star shape
                var centerX = width / 2
                var centerY = height / 2
                var spikes = 5
                var outerRadius = width / 2
                var innerRadius = outerRadius * 0.4
                
                for (var i = 0; i < spikes * 2; i++) {
                    var radius = i % 2 === 0 ? outerRadius : innerRadius
                    var angle = (Math.PI / spikes) * i
                    var x = centerX + Math.cos(angle) * radius
                    var y = centerY + Math.sin(angle) * radius
                    
                    if (i === 0) {
                        ctx.moveTo(x, y)
                    } else {
                        ctx.lineTo(x, y)
                    }
                }
                
                ctx.closePath()
                ctx.fill()
            }
        }

        // Shine effect
        Rectangle {
            width: parent.width * 0.3
            height: parent.height * 0.3
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 5
            radius: width / 2
            color: "#ffffff"
            opacity: 0.8
        }
    }

    // Floating animation
    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        NumberAnimation {
            target: star
            property: "y"
            to: star.y - 10
            duration: 1000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: star
            property: "y"
            to: star.y + 10
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }

    // Rotation animation
    RotationAnimation {
        target: star
        running: true
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 3000
        direction: RotationAnimation.Clockwise
    }

    // Collection animation
    SequentialAnimation {
        id: collectAnimation
        running: collected
        NumberAnimation {
            target: star
            property: "scale"
            to: 1.5
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: star
            property: "opacity"
            to: 0
            duration: 200
            easing.type: Easing.InQuad
        }
        onFinished: star.destroy()
    }

    // Particle effect on collection
    ParticleSystem {
        id: particleSystem
        running: collected

        Emitter {
            id: emitter
            anchors.centerIn: parent
            emitRate: 100
            lifeSpan: 500
            size: 8
            sizeVariation: 4
            velocity: AngleDirection {
                angle: 0
                angleVariation: 360
                magnitude: 100
                magnitudeVariation: 50
            }
        }

        ParticlePainter {
            delegate: Rectangle {
                width: 4
                height: 4
                radius: 2
                color: "#f1c40f"
                opacity: 0.8
            }
        }
    }
} 