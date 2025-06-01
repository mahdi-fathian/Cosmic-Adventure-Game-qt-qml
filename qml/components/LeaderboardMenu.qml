import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill: parent
    color: "#80000000" // Semi-transparent black
    visible: gameEngine.isLeaderboardOpen

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
                text: "Leaderboard"
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

            // Trophy icon
            Image {
                width: 100
                height: 100
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

            // Leaderboard list
            Rectangle {
                width: parent.width
                height: 400
                radius: Theme.cornerRadius
                color: Theme.primaryColor
                opacity: 0.9

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.standardGlow

                ListView {
                    id: leaderboardList
                    anchors.fill: parent
                    anchors.margins: 10
                    model: gameEngine.leaderboard
                    clip: true
                    spacing: 5

                    delegate: Rectangle {
                        width: parent.width
                        height: 60
                        radius: Theme.cornerRadius
                        color: index % 2 === 0 ? Theme.secondaryColor : Theme.accentColor
                        opacity: 0.9

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
                            opacity = 0.9
                        }

                        Row {
                            anchors {
                                fill: parent
                                margins: 10
                            }
                            spacing: 10

                            // Rank
                            Text {
                                text: "#" + (index + 1)
                                font: Theme.subtitleFont
                                color: Theme.textColor
                                width: 50
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            // Player name
                            Text {
                                text: modelData.name
                                font: Theme.textFont
                                color: Theme.textColor
                                width: parent.width * 0.4
                                anchors.verticalCenter: parent.verticalCenter
                                elide: Text.ElideRight
                            }

                            // Score
                            Text {
                                text: modelData.score
                                font: Theme.subtitleFont
                                color: Theme.textColor
                                width: parent.width * 0.3
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Text.AlignRight
                            }

                            // Date
                            Text {
                                text: modelData.date
                                font: Theme.textFont
                                color: Theme.textColor
                                width: parent.width * 0.2
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Text.AlignRight
                            }
                        }
                    }
                }
            }

            // Stats summary
            Rectangle {
                width: parent.width
                height: 100
                radius: Theme.cornerRadius
                color: Theme.secondaryColor
                opacity: 0.9

                // Glow effect
                layer.enabled: true
                layer.effect: Theme.standardGlow

                Row {
                    anchors {
                        centerIn: parent
                        margins: 20
                    }
                    spacing: 20

                    // Total players
                    Column {
                        spacing: 5

                        Text {
                            text: "Total Players"
                            font: Theme.textFont
                            color: Theme.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: gameEngine.totalPlayers
                            font: Theme.subtitleFont
                            color: Theme.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    // Average score
                    Column {
                        spacing: 5

                        Text {
                            text: "Average Score"
                            font: Theme.textFont
                            color: Theme.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: gameEngine.averageScore
                            font: Theme.subtitleFont
                            color: Theme.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    // Highest score
                    Column {
                        spacing: 5

                        Text {
                            text: "Highest Score"
                            font: Theme.textFont
                            color: Theme.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: gameEngine.highestScore
                            font: Theme.subtitleFont
                            color: Theme.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }

            // Close button
            CustomButton {
                text: "Close"
                isAccent: true
                onClicked: {
                    gameEngine.closeLeaderboard()
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