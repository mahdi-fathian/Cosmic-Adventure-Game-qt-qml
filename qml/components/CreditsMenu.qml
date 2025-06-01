import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill: parent
    color: "#80000000" // Semi-transparent black
    visible: gameEngine.isCreditsOpen

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
        width: 600
        height: 700
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
                text: "Credits"
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

            // Game logo
            Image {
                width: 200
                height: 200
                source: "qrc:/assets/images/logo.png"
                anchors.horizontalCenter: parent.horizontalCenter

                // Logo pulse animation
                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation {
                        target: logoImage
                        property: "scale"
                        from: 1.0
                        to: 1.1
                        duration: Theme.animationDuration
                        easing: Theme.standardEasing
                    }
                    NumberAnimation {
                        target: logoImage
                        property: "scale"
                        from: 1.1
                        to: 1.0
                        duration: Theme.animationDuration
                        easing: Theme.standardEasing
                    }
                }

                // Logo glow
                layer.enabled: true
                layer.effect: Theme.accentGlow
            }

            // Development team section
            Rectangle {
                width: parent.width
                height: 200
                radius: Theme.cornerRadius
                color: Theme.primaryColor
                opacity: 0.9

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.standardGlow

                Column {
                    anchors {
                        centerIn: parent
                        margins: 20
                    }
                    spacing: Theme.spacing

                    Text {
                        text: "Development Team"
                        font: Theme.subtitleFont
                        color: Theme.textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Team members
                    Repeater {
                        model: gameEngine.teamMembers

                        Row {
                            width: parent.width
                            spacing: 10

                            Text {
                                text: modelData.role
                                font: Theme.textFont
                                color: Theme.textColor
                                width: parent.width * 0.4
                            }

                            Text {
                                text: modelData.name
                                font: Theme.textFont
                                color: Theme.textColor
                                width: parent.width * 0.6
                                horizontalAlignment: Text.AlignRight
                            }
                        }
                    }
                }
            }

            // Special thanks section
            Rectangle {
                width: parent.width
                height: 150
                radius: Theme.cornerRadius
                color: Theme.secondaryColor
                opacity: 0.9

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.standardGlow

                Column {
                    anchors {
                        centerIn: parent
                        margins: 20
                    }
                    spacing: Theme.spacing

                    Text {
                        text: "Special Thanks"
                        font: Theme.subtitleFont
                        color: Theme.textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // Thanks list
                    Repeater {
                        model: gameEngine.specialThanks

                        Text {
                            text: modelData
                            font: Theme.textFont
                            color: Theme.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }

            // Version info
            Rectangle {
                width: parent.width
                height: 100
                radius: Theme.cornerRadius
                color: Theme.accentColor
                opacity: 0.9

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.accentGlow

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        text: "Cosmic Adventure"
                        font: Theme.subtitleFont
                        color: Theme.textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Version " + gameEngine.version
                        font: Theme.textFont
                        color: Theme.textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "© 2024 All Rights Reserved"
                        font: Theme.textFont
                        color: Theme.textColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Close button
            CustomButton {
                text: "Close"
                isAccent: true
                onClicked: {
                    gameEngine.closeCredits()
                }
            }
        }
    }

    // Particle effect
    ParticleSystem {
        id: particleSystem
        anchors.fill: parent

        Emitter {
            id: emitter
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            emitRate: 20
            lifeSpan: 3000
            size: 8
            endSize: 0
            velocity: AngleDirection {
                angle: 90
                angleVariation: 45
                magnitude: 100
                magnitudeVariation: 50
            }
        }

        ImageParticle {
            source: "qrc:/assets/images/particle.png"
            color: Theme.accentColor
            alpha: 0.5
            entryEffect: ImageParticle.Fade
        }
    }
} 