import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: root
    anchors.fill: parent
    color: Theme.backgroundColor

    // Background with parallax effect
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/assets/images/background.png"
        fillMode: Image.PreserveAspectCrop

        // Parallax effect
        property real offset: 0
        x: offset

        NumberAnimation on offset {
            from: -20
            to: 20
            duration: 10000
            running: true
            loops: Animation.Infinite
            easing.type: Easing.InOutQuad
        }
    }

    // Title with glow effect
    Text {
        id: titleText
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 100
        }
        text: "Cosmic Adventure"
        font: Theme.titleFont
        color: Theme.textColor

        // Glow effect
        layer.enabled: true
        layer.effect: Theme.accentGlow

        // Floating animation
        NumberAnimation on y {
            from: titleText.y
            to: titleText.y + 20
            duration: 2000
            running: true
            loops: Animation.Infinite
            easing.type: Easing.InOutQuad
        }
    }

    // Menu container
    Column {
        id: menuContainer
        anchors.centerIn: parent
        spacing: Theme.spacing

        // Play button
        CustomButton {
            text: "Play"
            isAccent: true
            onClicked: {
                gameEngine.startGame()
                mainStackView.replace("qrc:/qml/scenes/GameScene.qml")
            }
        }

        // Settings button
        CustomButton {
            text: "Settings"
            onClicked: {
                settingsDialog.open()
            }
        }

        // Leaderboard button
        CustomButton {
            text: "Leaderboard"
            onClicked: {
                leaderboardDialog.open()
            }
        }

        // Exit button
        CustomButton {
            text: "Exit"
            onClicked: {
                Qt.quit()
            }
        }
    }

    // Settings dialog
    Dialog {
        id: settingsDialog
        title: "Settings"
        modal: true
        anchors.centerIn: parent
        width: 400
        height: 300

        background: Rectangle {
            color: Theme.backgroundColor
            radius: Theme.cornerRadius
            layer.enabled: true
            layer.effect: Theme.standardGlow
        }

        Column {
            anchors.fill: parent
            spacing: Theme.spacing

            // Volume slider
            Slider {
                id: volumeSlider
                width: parent.width
                from: 0
                to: 1
                value: 0.5
                onValueChanged: {
                    gameEngine.setVolume(value)
                }
            }

            // Music toggle
            Switch {
                text: "Music"
                checked: true
                onCheckedChanged: {
                    gameEngine.setMusicEnabled(checked)
                }
            }

            // Sound effects toggle
            Switch {
                text: "Sound Effects"
                checked: true
                onCheckedChanged: {
                    gameEngine.setSoundEffectsEnabled(checked)
                }
            }
        }

        // Close button
        CustomButton {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            text: "Close"
            onClicked: settingsDialog.close()
        }
    }

    // Leaderboard dialog
    Dialog {
        id: leaderboardDialog
        title: "Leaderboard"
        modal: true
        anchors.centerIn: parent
        width: 400
        height: 400

        background: Rectangle {
            color: Theme.backgroundColor
            radius: Theme.cornerRadius
            layer.enabled: true
            layer.effect: Theme.standardGlow
        }

        ListView {
            id: leaderboardList
            anchors.fill: parent
            model: gameEngine.leaderboard
            delegate: Rectangle {
                width: parent.width
                height: 40
                color: index % 2 === 0 ? Theme.primaryColor : Theme.secondaryColor
                radius: Theme.cornerRadius

                Row {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        text: index + 1
                        font: Theme.textFont
                        color: Theme.textColor
                    }

                    Text {
                        text: modelData.name
                        font: Theme.textFont
                        color: Theme.textColor
                        width: parent.width * 0.6
                    }

                    Text {
                        text: modelData.score
                        font: Theme.textFont
                        color: Theme.textColor
                        width: parent.width * 0.3
                    }
                }
            }
        }

        // Close button
        CustomButton {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            text: "Close"
            onClicked: leaderboardDialog.close()
        }
    }

    // Background music
    Audio {
        id: backgroundMusic
        source: "qrc:/assets/sounds/background.mp3"
        loops: Audio.Infinite
        volume: 0.5
        playing: true
    }
} 