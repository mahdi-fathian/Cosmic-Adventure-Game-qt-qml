import QtQuick
import QtGraphicalEffects

Item {
    id: background
    anchors.fill: parent

    // Space background
    Rectangle {
        id: spaceBackground
        anchors.fill: parent
        color: "#000000"

        // Stars
        Repeater {
            model: 100
            Rectangle {
                width: Math.random() * 3 + 1
                height: width
                radius: width / 2
                color: "#ffffff"
                opacity: Math.random() * 0.8 + 0.2
                x: Math.random() * parent.width
                y: Math.random() * parent.height

                // Twinkling animation
                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation {
                        target: this
                        property: "opacity"
                        to: Math.random() * 0.8 + 0.2
                        duration: Math.random() * 2000 + 1000
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: this
                        property: "opacity"
                        to: Math.random() * 0.8 + 0.2
                        duration: Math.random() * 2000 + 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Nebula effect
        Rectangle {
            anchors.fill: parent
            color: "transparent"

            // Red nebula
            Rectangle {
                width: parent.width * 0.6
                height: parent.height * 0.4
                anchors.top: parent.top
                anchors.right: parent.right
                color: "#ff0000"
                opacity: 0.1
                radius: width

                // Blur effect
                layer.enabled: true
                layer.effect: GaussianBlur {
                    radius: 50
                    samples: 25
                }
            }

            // Blue nebula
            Rectangle {
                width: parent.width * 0.5
                height: parent.height * 0.3
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                color: "#0000ff"
                opacity: 0.1
                radius: width

                // Blur effect
                layer.enabled: true
                layer.effect: GaussianBlur {
                    radius: 50
                    samples: 25
                }
            }

            // Purple nebula
            Rectangle {
                width: parent.width * 0.4
                height: parent.height * 0.35
                anchors.centerIn: parent
                color: "#800080"
                opacity: 0.1
                radius: width

                // Blur effect
                layer.enabled: true
                layer.effect: GaussianBlur {
                    radius: 50
                    samples: 25
                }
            }
        }

        // Parallax scrolling effect
        property real scrollOffset: 0
        NumberAnimation {
            target: spaceBackground
            property: "scrollOffset"
            from: 0
            to: 1
            duration: 10000
            loops: Animation.Infinite
            running: true
        }
    }

    // Grid lines
    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.strokeStyle = "#ffffff"
            ctx.lineWidth = 1
            ctx.globalAlpha = 0.1

            // Draw vertical lines
            for (var x = 0; x < width; x += 50) {
                ctx.beginPath()
                ctx.moveTo(x, 0)
                ctx.lineTo(x, height)
                ctx.stroke()
            }

            // Draw horizontal lines
            for (var y = 0; y < height; y += 50) {
                ctx.beginPath()
                ctx.moveTo(0, y)
                ctx.lineTo(width, y)
                ctx.stroke()
            }
        }
    }

    // Particle system for space dust
    ParticleSystem {
        anchors.fill: parent

        Emitter {
            anchors.fill: parent
            emitRate: 10
            lifeSpan: 5000
            size: 2
            sizeVariation: 1
            velocity: AngleDirection {
                angle: 270
                angleVariation: 30
                magnitude: 20
                magnitudeVariation: 10
            }
        }

        ParticlePainter {
            delegate: Rectangle {
                width: 2
                height: 2
                radius: 1
                color: "#ffffff"
                opacity: 0.5
            }
        }
    }
} 