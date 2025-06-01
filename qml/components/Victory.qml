import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: victory
    anchors.fill: parent

    // Properties
    property bool isActive: true
    property int finalScore: 0
    property int stars: 0
    property int timeBonus: 0
    property int totalScore: 0

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

    // Victory container
    Rectangle {
        id: victoryContainer
        width: 500
        height: 600
        anchors.centerIn: parent
        color: "#1a1a1a"
        radius: 20
        opacity: 0.9

        // Blur effect
        GaussianBlur {
            anchors.fill: victoryContainer
            source: victoryContainer
            radius: 10
            samples: 25
        }

        // Border glow
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            border.color: "#2ecc71"
            border.width: 2

            // Glow effect
            Glow {
                anchors.fill: parent
                radius: 8
                samples: 17
                color: "#2ecc71"
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
            text: "Victory!"
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
                color: "#2ecc71"
                source: titleText
            }

            // Floating animation
            SequentialAnimation {
                running: true
                loops: Animation.Infinite
                NumberAnimation {
                    target: titleText
                    property: "y"
                    from: titleText.y
                    to: titleText.y - 10
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: titleText
                    property: "y"
                    to: titleText.y
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // Stars
        Row {
            anchors {
                top: titleText.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 40
            }
            spacing: 20

            Repeater {
                model: 3
                Rectangle {
                    width: 40
                    height: 40
                    radius: width / 2
                    color: index < stars ? "#f1c40f" : "#4a4a4a"
                    opacity: 0.8

                    // Star glow
                    Glow {
                        anchors.fill: parent
                        radius: 8
                        samples: 17
                        color: "#f1c40f"
                        source: parent
                        visible: index < stars
                    }

                    // Star animation
                    SequentialAnimation {
                        running: index < stars
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: this
                            property: "scale"
                            from: 1
                            to: 1.2
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                        NumberAnimation {
                            target: this
                            property: "scale"
                            to: 1
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }

        // Score display
        Column {
            anchors {
                top: titleText.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 120
            }
            spacing: 20

            // Final score
            Text {
                text: "Level Score: " + finalScore
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

            // Time bonus
            Text {
                text: "Time Bonus: +" + timeBonus
                color: "#2ecc71"
                font.pixelSize: 24
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
            }

            // Total score
            Text {
                text: "Total Score: " + totalScore
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
        }

        // Buttons
        Column {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 40
            }
            spacing: 20

            // Next level button
            Button {
                id: nextLevelButton
                width: 200
                height: 50
                text: "Next Level"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: nextLevelButton.pressed ? "#27ae60" : "#2ecc71"
                    radius: 10

                    // Glow effect
                    Glow {
                        anchors.fill: parent
                        radius: 8
                        samples: 17
                        color: "#2ecc71"
                        source: parent
                    }
                }

                contentItem: Text {
                    text: nextLevelButton.text
                    font: nextLevelButton.font
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                // Hover animation
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            nextLevelButton.scale = 1.1
                        } else {
                            nextLevelButton.scale = 1.0
                        }
                    }
                }

                // Click animation
                onClicked: {
                    nextLevelButton.scale = 0.9
                    nextLevelTimer.start()
                }

                Timer {
                    id: nextLevelTimer
                    interval: 100
                    onTriggered: {
                        nextLevelButton.scale = 1.0
                        victory.nextLevel()
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
                        victory.goToMainMenu()
                    }
                }
            }
        }
    }

    // Signals
    signal nextLevel()
    signal goToMainMenu()
} 