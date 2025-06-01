import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    anchors.fill: parent

    property bool isActive: false

    // Background overlay
    Rectangle {
        id: overlay
        anchors.fill: parent
        color: "#80000000"

        // Blur effect
        MultiEffect {
            anchors.fill: parent
            source: parent
            blurEnabled: true
            blurMax: 8
            blur: 8
        }
    }

    // Menu container
    Rectangle {
        id: menuContainer
        width: 400
        height: 500
        anchors.centerIn: parent
        color: "#1A000000"
        radius: 20

        // Blur effect
        MultiEffect {
            anchors.fill: parent
            source: parent
            blurEnabled: true
            blurMax: 8
            blur: 8
        }

        // Border glow
        layer.enabled: true
        layer.effect: Glow {
            color: "#2196F3"
            radius: 8
            samples: 17
            transparentBorder: true
        }

        // Title
        Text {
            id: title
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: 40
            }
            text: "PAUSED"
            color: "#FFFFFF"
            font.pixelSize: 48
            font.bold: true

            // Text outline
            layer.enabled: true
            layer.effect: Glow {
                color: "#2196F3"
                radius: 8
                samples: 17
                transparentBorder: true
            }
        }

        // Menu buttons
        Column {
            anchors {
                top: title.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 60
            }
            spacing: 20

            // Resume button
            Rectangle {
                id: resumeButton
                width: 300
                height: 60
                color: "#2196F3"
                radius: 10

                // Button glow
                layer.enabled: true
                layer.effect: Glow {
                    color: "#1976D2"
                    radius: 8
                    samples: 17
                    transparentBorder: true
                }

                Text {
                    anchors.centerIn: parent
                    text: "Resume"
                    color: "#FFFFFF"
                    font.pixelSize: 24
                    font.bold: true
                }

                // Hover effect
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
                        easing.type: Easing.InQuad
                    }
                    NumberAnimation {
                        target: resumeButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }

                // Click handler
                TapHandler {
                    onTapped: {
                        resumeClickAnimation.start()
                        resumeTimer.start()
                    }
                }

                // Resume timer
                Timer {
                    id: resumeTimer
                    interval: 200
                    onTriggered: root.resumeGame()
                }
            }

            // Settings button
            Rectangle {
                id: settingsButton
                width: 300
                height: 60
                color: "#2196F3"
                radius: 10

                // Button glow
                layer.enabled: true
                layer.effect: Glow {
                    color: "#1976D2"
                    radius: 8
                    samples: 17
                    transparentBorder: true
                }

                Text {
                    anchors.centerIn: parent
                    text: "Settings"
                    color: "#FFFFFF"
                    font.pixelSize: 24
                    font.bold: true
                }

                // Hover effect
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
                        easing.type: Easing.InQuad
                    }
                    NumberAnimation {
                        target: settingsButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }

                // Click handler
                TapHandler {
                    onTapped: {
                        settingsClickAnimation.start()
                        settingsTimer.start()
                    }
                }

                // Settings timer
                Timer {
                    id: settingsTimer
                    interval: 200
                    onTriggered: root.openSettings()
                }
            }

            // Main menu button
            Rectangle {
                id: mainMenuButton
                width: 300
                height: 60
                color: "#2196F3"
                radius: 10

                // Button glow
                layer.enabled: true
                layer.effect: Glow {
                    color: "#1976D2"
                    radius: 8
                    samples: 17
                    transparentBorder: true
                }

                Text {
                    anchors.centerIn: parent
                    text: "Main Menu"
                    color: "#FFFFFF"
                    font.pixelSize: 24
                    font.bold: true
                }

                // Hover effect
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
                        easing.type: Easing.InQuad
                    }
                    NumberAnimation {
                        target: mainMenuButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }

                // Click handler
                TapHandler {
                    onTapped: {
                        mainMenuClickAnimation.start()
                        mainMenuTimer.start()
                    }
                }

                // Main menu timer
                Timer {
                    id: mainMenuTimer
                    interval: 200
                    onTriggered: root.goToMainMenu()
                }
            }
        }
    }

    // Signals
    signal resumeGame()
    signal openSettings()
    signal goToMainMenu()
} 