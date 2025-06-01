import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Effects
import QtQuick.Window
import "components" as Components

Window {
    id: window
    width: 1280
    height: 720
    visible: true
    title: "Cosmic Adventure"
    color: "#000000"

    // Game states
    property int gameState: 0 // 0: Main Menu, 1: Game, 2: Level Select, 3: Settings, 4: Credits
    property int currentLevel: 1
    property int score: 0
    property int lives: 3
    property bool isPaused: false

    // Stack view for managing scenes
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: mainMenu
    }

    // Main menu component
    Component {
        id: mainMenu
        Components.MainMenu {
            onStartGame: {
                gameState = 1
                stackView.push(gameScene)
            }
            onOpenLevelSelect: {
                gameState = 2
                stackView.push(levelSelect)
            }
            onOpenSettings: {
                gameState = 3
                stackView.push(settings)
            }
            onOpenCredits: {
                gameState = 4
                stackView.push(credits)
            }
            onQuitGame: Qt.quit()
        }
    }

    // Game scene component
    Component {
        id: gameScene
        Rectangle {
            color: "#000000"
            
            // Game area
            Rectangle {
                id: gameArea
                anchors.fill: parent
                color: "transparent"

                // Starry background
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

                // Player
                Components.SpaceHero {
                    id: player
                    x: parent.width / 2 - width / 2
                    y: parent.height - height - 50
                }

                // HUD
                Rectangle {
                    id: hud
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                    height: 60
                    color: "#1A000000"

                    // Score
                    Text {
                        id: scoreText
                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            leftMargin: 20
                        }
                        text: "Score: " + score
                        color: "#FFFFFF"
                        font.pixelSize: 24
                        font.bold: true
                    }

                    // Lives
                    Row {
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            rightMargin: 20
                        }
                        spacing: 10

                        Repeater {
                            model: lives
                            Rectangle {
                                width: 30
                                height: 30
                                radius: width / 2
                                color: "#4CAF50"

                                // Glow effect
                                MultiEffect {
                                    anchors.fill: parent
                                    source: parent
                                    blurEnabled: true
                                    blurMax: 8
                                    blur: 8
                                    colorization: 1.0
                                    colorizationColor: "#4CAF50"
                                }
                            }
                        }
                    }
                }
            }

            // Level info
            Components.Level {
                id: levelInfo
                anchors.centerIn: parent
                levelNumber: currentLevel
                isActive: gameState === 1
            }

            // Game message
            Components.GameMessage {
                id: gameMessage
                anchors.centerIn: parent
            }

            // Pause menu
            Components.PauseMenu {
                id: pauseMenu
                anchors.fill: parent
                isActive: isPaused
                onResumeGame: isPaused = false
                onOpenSettings: {
                    isPaused = false
                    stackView.push(settings)
                }
                onGoToMainMenu: {
                    isPaused = false
                    stackView.pop()
                }
            }

            // Game over screen
            Components.GameOver {
                id: gameOver
                anchors.fill: parent
                isActive: lives <= 0
                finalScore: score
                onRestartGame: {
                    lives = 3
                    score = 0
                    currentLevel = 1
                    stackView.pop()
                }
                onGoToMainMenu: {
                    lives = 3
                    score = 0
                    currentLevel = 1
                    stackView.pop()
                }
            }

            // Victory screen
            Components.Victory {
                id: victory
                anchors.fill: parent
                isActive: gameState === 1 && currentLevel > 10
                finalScore: score
                onNextLevel: {
                    currentLevel++
                    score += 1000
                }
                onGoToMainMenu: stackView.pop()
            }
        }
    }

    // Level select component
    Component {
        id: levelSelect
        Components.LevelSelect {
            onLevelSelected: {
                currentLevel = level
                gameState = 1
                stackView.push(gameScene)
            }
            onBack: stackView.pop()
        }
    }

    // Settings component
    Component {
        id: settings
        Components.Settings {
            onBack: stackView.pop()
        }
    }

    // Credits component
    Component {
        id: credits
        Components.Credits {
            onBack: stackView.pop()
        }
    }

    // Keyboard shortcuts
    Keys.onEscapePressed: {
        if (gameState === 1) {
            isPaused = !isPaused
        }
    }

    // Start level
    Component.onCompleted: {
        levelInfo.showLevel(currentLevel)
        gameMessage.showMessage("Level " + currentLevel, "#FFFFFF")
    }
} 