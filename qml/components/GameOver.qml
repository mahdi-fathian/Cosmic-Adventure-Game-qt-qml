import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: gameOver
    anchors.fill: parent

    // Properties
    property bool isActive: true
    property int finalScore: 0
    property int highScore: 0
    property bool isNewHighScore: false

    // Background overlay
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.7

        // Blur effect
        GaussianBlur {
            anchors.fill: parent
            source: parent
            radius: 20
            samples: 25
        }
    }

    // Game over container
    Rectangle {
        id: gameOverContainer
        width: 500
        height: 600
        anchors.centerIn: parent
        color: "#1a1a1a"
        radius: 20
        opacity: 0.9

        // Blur effect
        GaussianBlur {
            anchors.fill: gameOverContainer
            source: gameOverContainer
            radius: 10
            samples: 25
        }

        // Border glow
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            border.color: "#e74c3c"
            border.width: 2

            // Glow effect
            Glow {
                anchors.fill: parent
                radius: 8
                samples: 17
                color: "#e74c3c"
                source: parent
            }
        }

        // Title
        Text {
            id: titleText
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: 40
            }
            text: "Game Over"
            color: "#ffffff"
            font.pixelSize: 48
            font.bold: true
            style: Text.Outline
            styleColor: "#000000"

            // Glow effect
            Glow {
                anchors.fill: titleText
                radius: 8
                samples: 17
                color: "#e74c3c"
                source: titleText
            }
        }

        // Score display
        Column {
            anchors {
                top: titleText.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 60
            }
            spacing: 20

            // Final score
            Text {
                text: "Final Score: " + finalScore
                color: "#ffffff"
                font.pixelSize: 32
                font.bold: true
                style: Text.Outline
                styleColor: "#000000"

                // Glow effect
                Glow {
                    anchors.fill: parent
                    radius: 8
                    samples: 17
                    color: "#f1c40f"
                    source: parent
                }
            }

            // High score
            Text {
                text: "High Score: " + highScore
                color: "#ffffff"
                font.pixelSize: 24
                font.bold: true
                style: Text.Outline
                styleColor: "#000000"

                // Glow effect
                Glow {
                    anchors.fill: parent
                    radius: 8
                    samples: 17
                    color: "#f1c40f"
                    source: parent
                }
            }

            // New high score message
            Text {
                visible: isNewHighScore
                text: "New High Score!"
                color: "#2ecc71"
                font.pixelSize: 28
                font.bold: true
                style: Text.Outline
                styleColor: "#000000"

                // Glow effect
                Glow {
                    anchors.fill: parent
                    radius: 8
                    samples: 17
                    color: "#2ecc71"
                    source: parent
                }

                // Floating animation
                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation {
                        target: this
                        property: "y"
                        from: y
                        to: y - 10
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: this
                        property: "y"
                        to: y
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        // Buttons
        Column {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 40
            }
            spacing: 20

            // Restart button
            Button {
                id: restartButton
                width: 200
                height: 50
                text: "Restart"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: restartButton.pressed ? "#2980b9" : "#3498db"
                    radius: 10

                    // Glow effect
                    Glow {
                        anchors.fill: parent
                        radius: 8
                        samples: 17
                        color: "#3498db"
                        source: parent
                    }
                }

                contentItem: Text {
                    text: restartButton.text
                    font: restartButton.font
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                // Hover animation
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            restartButton.scale = 1.1
                        } else {
                            restartButton.scale = 1.0
                        }
                    }
                }

                // Click animation
                onClicked: {
                    restartButton.scale = 0.9
                    restartTimer.start()
                }

                Timer {
                    id: restartTimer
                    interval: 100
                    onTriggered: {
                        restartButton.scale = 1.0
                        gameOver.restartGame()
                    }
                }
            }

            // Main menu button
            Button {
                id: mainMenuButton
                width: 200
                height: 50
                text: "Main Menu"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: mainMenuButton.pressed ? "#2980b9" : "#3498db"
                    radius: 10

                    // Glow effect
                    Glow {
                        anchors.fill: parent
                        radius: 8
                        samples: 17
                        color: "#3498db"
                        source: parent
                    }
                }

                contentItem: Text {
                    text: mainMenuButton.text
                    font: mainMenuButton.font
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                // Hover animation
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            mainMenuButton.scale = 1.1
                        } else {
                            mainMenuButton.scale = 1.0
                        }
                    }
                }

                // Click animation
                onClicked: {
                    mainMenuButton.scale = 0.9
                    mainMenuTimer.start()
                }

                Timer {
                    id: mainMenuTimer
                    interval: 100
                    onTriggered: {
                        mainMenuButton.scale = 1.0
                        gameOver.goToMainMenu()
                    }
                }
            }
        }
    }

    // Signals
    signal restartGame()
    signal goToMainMenu()
} 