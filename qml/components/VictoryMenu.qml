import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill: parent
    color: "#80000000" // Semi-transparent black
    visible: gameEngine.isGameWon

    // Blur effect
    ShaderEffect {
        anchors.fill: parent
        property real blurAmount: 10
        fragmentShader: "
            #version 440
            layout(location = 0) in vec2 qt_TexCoord0;
            layout(location = 0) out vec4 fragColor;
            layout(binding = 0) uniform sampler2D source;
            layout(binding = 1) uniform float blurAmount;
            void main() {
                vec2 texCoord = qt_TexCoord0;
                vec4 color = vec4(0.0);
                float total = 0.0;
                for(float i = -blurAmount; i <= blurAmount; i++) {
                    for(float j = -blurAmount; j <= blurAmount; j++) {
                        vec2 offset = vec2(i, j) / 100.0;
                        color += texture(source, texCoord + offset);
                        total += 1.0;
                    }
                }
                fragColor = color / total;
            }
        "
    }

    // Menu container
    Rectangle {
        id: menuContainer
        anchors.centerIn: parent
        width: 500
        height: 600
        radius: Theme.cornerRadius
        color: Theme.backgroundColor
        opacity: 0.95

        // Glow effect
        layer.enabled: true
        layer.effect: Theme.standardGlow

        // Scale animation
        scale: 0.8
        opacity: 0
        Behavior on scale {
            NumberAnimation {
                duration: Theme.animationDuration
                easing: Theme.standardEasing
            }
        }
        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animationDuration
                easing: Theme.standardEasing
            }
        }

        // Show animation
        Component.onCompleted: {
            scale = 1.0
            opacity = 0.95
        }

        Column {
            anchors {
                centerIn: parent
                margins: 20
            }
            spacing: Theme.spacing

            // Title
            Text {
                text: "Victory!"
                font: Theme.titleFont
                color: Theme.textColor
                anchors.horizontalCenter: parent.horizontalCenter

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.accentGlow

                // Floating animation
                NumberAnimation on y {
                    from: y
                    to: y + 10
                    duration: 2000
                    running: true
                    loops: Animation.Infinite
                    easing.type: Easing.InOutQuad
                }
            }

            // Trophy
            Image {
                width: 150
                height: 150
                source: "qrc:/assets/images/trophy.png"
                anchors.horizontalCenter: parent.horizontalCenter

                // Trophy spin animation
                NumberAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 5000
                    loops: Animation.Infinite
                    running: true
                }

                // Trophy glow
                layer.enabled: true
                layer.effect: Theme.accentGlow
            }

            // Score display
            Rectangle {
                width: parent.width
                height: 100
                radius: Theme.cornerRadius
                color: Theme.primaryColor
                opacity: 0.9

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.standardGlow

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        text: "Final Score"
                        font: Theme.subtitleFont
                        color: Theme.textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: gameEngine.score
                        font: Theme.titleFont
                        color: Theme.textColor
                        anchors.horizontalCenter: parent.horizontalCenter

                        // Score animation
                        NumberAnimation on scale {
                            from: 0.5
                            to: 1.0
                            duration: Theme.animationDuration
                            easing: Theme.standardEasing
                        }
                    }
                }
            }

            // Stats display
            Rectangle {
                width: parent.width
                height: 120
                radius: Theme.cornerRadius
                color: Theme.secondaryColor
                opacity: 0.9

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.standardGlow

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        text: "Levels Completed: " + gameEngine.level
                        font: Theme.textFont
                        color: Theme.textColor
                    }

                    Text {
                        text: "Coins Collected: " + gameEngine.coins
                        font: Theme.textFont
                        color: Theme.textColor
                    }

                    Text {
                        text: "Power-ups Used: " + gameEngine.powerUpsUsed
                        font: Theme.textFont
                        color: Theme.textColor
                    }
                }
            }

            // New game button
            CustomButton {
                text: "New Game"
                isAccent: true
                onClicked: {
                    gameEngine.resetGame()
                    gameEngine.startGame()
                }
            }

            // Main menu button
            CustomButton {
                text: "Main Menu"
                onClicked: {
                    gameEngine.resetGame()
                    mainStackView.replace("qrc:/qml/scenes/MainMenu.qml")
                }
            }
        }
    }

    // Confetti effect
    ParticleSystem {
        id: confettiSystem
        anchors.fill: parent

        Emitter {
            id: confettiEmitter
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            emitRate: 100
            lifeSpan: 3000
            size: 10
            endSize: 5
            velocity: AngleDirection {
                angle: 90
                angleVariation: 45
                magnitude: 200
                magnitudeVariation: 100
            }
        }

        ImageParticle {
            source: "qrc:/assets/images/confetti.png"
            colorVariation: 0.5
            alpha: 0.8
            entryEffect: ImageParticle.Fade
        }
    }

    // Victory sound
    SoundEffect {
        id: victorySound
        source: "qrc:/assets/sounds/victory.wav"
        volume: 0.5
        Component.onCompleted: {
            victorySound.play()
        }
    }
} 