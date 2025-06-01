import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: gameMenu
    anchors.fill: parent

    // Background
    Background {
        anchors.fill: parent
    }

    // Menu container
    Rectangle {
        id: menuContainer
        width: 400
        height: 500
        anchors.centerIn: parent
        color: "#1a1a1a"
        radius: 20
        opacity: 0.9

        // Blur effect
        layer.enabled: true
        layer.effect: GaussianBlur {
            radius: 10
            samples: 25
        }

        // Title
        Text {
            id: title
            text: "Game Menu"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            font.pixelSize: 32
            font.bold: true
            color: "#ffffff"

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                color: "#4a90e2"
                radius: 8
                samples: 17
                transparentBorder: true
            }
        }

        // Menu content
        Column {
            anchors.centerIn: parent
            spacing: 30

            // Resume button
            Button {
                id: resumeButton
                width: 200
                height: 50
                text: "Resume"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: resumeButton.pressed ? "#2ecc71" : "#27ae60"
                    radius: 10

                    // Glow effect
                    layer.enabled: true
                    layer.effect: Glow {
                        color: "#2ecc71"
                        radius: 8
                        samples: 17
                        transparentBorder: true
                    }
                }

                contentItem: Text {
                    text: resumeButton.text
                    font: resumeButton.font
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                // Hover animation
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            resumeButton.scale = 1.1
                        } else {
                            resumeButton.scale = 1.0
                        }
                    }
                }

                // Click animation
                SequentialAnimation {
                    id: resumeClickAnimation
                    NumberAnimation {
                        target: resumeButton
                        property: "scale"
                        to: 0.9
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: resumeButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.InQuad
                    }
                }

                onClicked: {
                    resumeClickAnimation.start()
                    // Emit signal to resume game
                    gameMenu.resumeGame()
                }
            }

            // Settings button
            Button {
                id: settingsButton
                width: 200
                height: 50
                text: "Settings"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: settingsButton.pressed ? "#3498db" : "#2980b9"
                    radius: 10

                    // Glow effect
                    layer.enabled: true
                    layer.effect: Glow {
                        color: "#3498db"
                        radius: 8
                        samples: 17
                        transparentBorder: true
                    }
                }

                contentItem: Text {
                    text: settingsButton.text
                    font: settingsButton.font
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                // Hover animation
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            settingsButton.scale = 1.1
                        } else {
                            settingsButton.scale = 1.0
                        }
                    }
                }

                // Click animation
                SequentialAnimation {
                    id: settingsClickAnimation
                    NumberAnimation {
                        target: settingsButton
                        property: "scale"
                        to: 0.9
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: settingsButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.InQuad
                    }
                }

                onClicked: {
                    settingsClickAnimation.start()
                    // Emit signal to open settings
                    gameMenu.openSettings()
                }
            }

            // Restart button
            Button {
                id: restartButton
                width: 200
                height: 50
                text: "Restart"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: restartButton.pressed ? "#f1c40f" : "#f39c12"
                    radius: 10

                    // Glow effect
                    layer.enabled: true
                    layer.effect: Glow {
                        color: "#f1c40f"
                        radius: 8
                        samples: 17
                        transparentBorder: true
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
                SequentialAnimation {
                    id: restartClickAnimation
                    NumberAnimation {
                        target: restartButton
                        property: "scale"
                        to: 0.9
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: restartButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.InQuad
                    }
                }

                onClicked: {
                    restartClickAnimation.start()
                    // Emit signal to restart game
                    gameMenu.restartGame()
                }
            }

            // Main Menu button
            Button {
                id: mainMenuButton
                width: 200
                height: 50
                text: "Main Menu"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: mainMenuButton.pressed ? "#e74c3c" : "#c0392b"
                    radius: 10

                    // Glow effect
                    layer.enabled: true
                    layer.effect: Glow {
                        color: "#e74c3c"
                        radius: 8
                        samples: 17
                        transparentBorder: true
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
                SequentialAnimation {
                    id: mainMenuClickAnimation
                    NumberAnimation {
                        target: mainMenuButton
                        property: "scale"
                        to: 0.9
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: mainMenuButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.InQuad
                    }
                }

                onClicked: {
                    mainMenuClickAnimation.start()
                    // Emit signal to go to main menu
                    gameMenu.goToMainMenu()
                }
            }
        }
    }

    // Signals
    signal resumeGame()
    signal openSettings()
    signal restartGame()
    signal goToMainMenu()
} 