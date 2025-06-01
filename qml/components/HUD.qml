import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: hud
    anchors.fill: parent

    // Score display
    Rectangle {
        id: scoreContainer
        width: 200
        height: 60
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        color: "#1a1a1a"
        radius: 10
        opacity: 0.9

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: "#4a90e2"
            radius: 8
            samples: 17
            transparentBorder: true
        }

        Column {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "Score"
                font.pixelSize: 16
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: scoreText
                text: "0"
                font.pixelSize: 24
                font.bold: true
                color: "#4a90e2"
                anchors.horizontalCenter: parent.horizontalCenter

                // Glow effect
                layer.enabled: true
                layer.effect: Glow {
                    color: "#4a90e2"
                    radius: 8
                    samples: 17
                    transparentBorder: true
                }
            }
        }
    }

    // Lives display
    Rectangle {
        id: livesContainer
        width: 200
        height: 60
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        color: "#1a1a1a"
        radius: 10
        opacity: 0.9

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: "#e74c3c"
            radius: 8
            samples: 17
            transparentBorder: true
        }

        Column {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "Lives"
                font.pixelSize: 16
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: 3
                    Rectangle {
                        width: 20
                        height: 20
                        radius: 10
                        color: "#e74c3c"

                        // Glow effect
                        layer.enabled: true
                        layer.effect: Glow {
                            color: "#e74c3c"
                            radius: 8
                            samples: 17
                            transparentBorder: true
                        }

                        // Heart shape
                        Canvas {
                            anchors.fill: parent
                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.fillStyle = "#ffffff"
                                ctx.beginPath()
                                
                                var centerX = width / 2
                                var centerY = height / 2
                                var size = width * 0.4
                                
                                ctx.moveTo(centerX, centerY + size)
                                ctx.bezierCurveTo(
                                    centerX, centerY + size * 0.8,
                                    centerX - size, centerY + size * 0.2,
                                    centerX - size, centerY - size * 0.2
                                )
                                ctx.bezierCurveTo(
                                    centerX - size, centerY - size * 0.8,
                                    centerX, centerY - size,
                                    centerX, centerY - size * 0.6
                                )
                                ctx.bezierCurveTo(
                                    centerX, centerY - size,
                                    centerX + size, centerY - size * 0.8,
                                    centerX + size, centerY - size * 0.2
                                )
                                ctx.bezierCurveTo(
                                    centerX + size, centerY + size * 0.2,
                                    centerX, centerY + size * 0.8,
                                    centerX, centerY + size
                                )
                                
                                ctx.fill()
                            }
                        }
                    }
                }
            }
        }
    }

    // Level display
    Rectangle {
        id: levelContainer
        width: 200
        height: 60
        anchors.top: scoreContainer.bottom
        anchors.left: parent.left
        anchors.margins: 20
        color: "#1a1a1a"
        radius: 10
        opacity: 0.9

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: "#f1c40f"
            radius: 8
            samples: 17
            transparentBorder: true
        }

        Column {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "Level"
                font.pixelSize: 16
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: levelText
                text: "1"
                font.pixelSize: 24
                font.bold: true
                color: "#f1c40f"
                anchors.horizontalCenter: parent.horizontalCenter

                // Glow effect
                layer.enabled: true
                layer.effect: Glow {
                    color: "#f1c40f"
                    radius: 8
                    samples: 17
                    transparentBorder: true
                }
            }
        }
    }

    // Power-ups display
    Rectangle {
        id: powerUpsContainer
        width: 200
        height: 60
        anchors.top: livesContainer.bottom
        anchors.right: parent.right
        anchors.margins: 20
        color: "#1a1a1a"
        radius: 10
        opacity: 0.9

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: "#9b59b6"
            radius: 8
            samples: 17
            transparentBorder: true
        }

        Column {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "Power-ups"
                font.pixelSize: 16
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: 3
                    Rectangle {
                        width: 30
                        height: 30
                        radius: 5
                        color: "#9b59b6"

                        // Glow effect
                        layer.enabled: true
                        layer.effect: Glow {
                            color: "#9b59b6"
                            radius: 8
                            samples: 17
                            transparentBorder: true
                        }

                        // Power-up icon
                        Text {
                            text: "★"
                            font.pixelSize: 20
                            color: "#ffffff"
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }

    // Score animation
    SequentialAnimation {
        id: scoreAnimation
        NumberAnimation {
            target: scoreText
            property: "scale"
            to: 1.5
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: scoreText
            property: "scale"
            to: 1.0
            duration: 200
            easing.type: Easing.InQuad
        }
    }

    // Level up animation
    SequentialAnimation {
        id: levelUpAnimation
        NumberAnimation {
            target: levelText
            property: "scale"
            to: 1.5
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: levelText
            property: "scale"
            to: 1.0
            duration: 200
            easing.type: Easing.InQuad
        }
    }

    // Functions
    function updateScore(score) {
        scoreText.text = score
        scoreAnimation.start()
    }

    function updateLives(lives) {
        // Update lives display
    }

    function updateLevel(level) {
        levelText.text = level
        levelUpAnimation.start()
    }

    function updatePowerUps(powerUps) {
        // Update power-ups display
    }
} 