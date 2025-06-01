import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: mainMenu
    anchors.fill: parent

    // Properties
    property bool isActive: true

    // Background
    Rectangle {
        anchors.fill: parent
        color: "#000000"

        // Stars background
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

        // Nebula effect
        Rectangle {
            anchors.fill: parent
            color: "transparent"

            // Nebula gradients
            Repeater {
                model: 5
                Rectangle {
                    width: parent.width * 2
                    height: parent.height * 2
                    x: -parent.width / 2
                    y: -parent.height / 2
                    radius: width
                    color: "transparent"
                    opacity: 0.1

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(Math.random(), Math.random(), Math.random(), 0.3) }
                        GradientStop { position: 1.0; color: "transparent" }
                    }

                    // Rotation animation
                    RotationAnimation {
                        target: this
                        running: true
                        loops: Animation.Infinite
                        from: 0
                        to: 360
                        duration: Math.random() * 20000 + 10000
                        direction: RotationAnimation.Clockwise
                    }
                }
            }
        }
    }

    // Game title
    Text {
        id: titleText
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 100
        }
        text: "Cosmic Adventure"
        color: "#ffffff"
        font.pixelSize: 64
        font.bold: true
        style: Text.Outline
        styleColor: "#000000"

        // Glow effect
        MultiEffect {
            anchors.fill: titleText
            source: titleText
            blurEnabled: true
            blurMax: 8
            blur: 8
            colorization: 1.0
            colorizationColor: "#3498db"
        }

        // Floating animation
        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            NumberAnimation {
                target: titleText
                property: "y"
                from: titleText.y
                to: titleText.y - 20
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: titleText
                property: "y"
                to: titleText.y
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }
    }

    // Menu buttons
    Column {
        anchors {
            top: titleText.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 100
        }
        spacing: 30

        // Play button
        Button {
            id: playButton
            width: 300
            height: 60
            text: "Play"
            font.pixelSize: 24
            font.bold: true

            background: Rectangle {
                color: playButton.pressed ? "#2980b9" : "#3498db"
                radius: 10

                // Glow effect
                MultiEffect {
                    anchors.fill: parent
                    source: parent
                    blurEnabled: true
                    blurMax: 8
                    blur: 8
                    colorization: 1.0
                    colorizationColor: "#3498db"
                }
            }

            contentItem: Text {
                text: playButton.text
                font: playButton.font
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // Hover animation
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        playButton.scale = 1.1
                    } else {
                        playButton.scale = 1.0
                    }
                }
            }

            // Click animation
            onClicked: {
                playButton.scale = 0.9
                playTimer.start()
            }

            Timer {
                id: playTimer
                interval: 100
                onTriggered: {
                    playButton.scale = 1.0
                    mainMenu.startGame()
                }
            }
        }

        // Level select button
        Button {
            id: levelSelectButton
            width: 300
            height: 60
            text: "Level Select"
            font.pixelSize: 24
            font.bold: true

            background: Rectangle {
                color: levelSelectButton.pressed ? "#2980b9" : "#3498db"
                radius: 10

                // Glow effect
                MultiEffect {
                    anchors.fill: parent
                    source: parent
                    blurEnabled: true
                    blurMax: 8
                    blur: 8
                    colorization: 1.0
                    colorizationColor: "#3498db"
                }
            }

            contentItem: Text {
                text: levelSelectButton.text
                font: levelSelectButton.font
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // Hover animation
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        levelSelectButton.scale = 1.1
                    } else {
                        levelSelectButton.scale = 1.0
                    }
                }
            }

            // Click animation
            onClicked: {
                levelSelectButton.scale = 0.9
                levelSelectTimer.start()
            }

            Timer {
                id: levelSelectTimer
                interval: 100
                onTriggered: {
                    levelSelectButton.scale = 1.0
                    mainMenu.openLevelSelect()
                }
            }
        }

        // Settings button
        Button {
            id: settingsButton
            width: 300
            height: 60
            text: "Settings"
            font.pixelSize: 24
            font.bold: true

            background: Rectangle {
                color: settingsButton.pressed ? "#2980b9" : "#3498db"
                radius: 10

                // Glow effect
                MultiEffect {
                    anchors.fill: parent
                    source: parent
                    blurEnabled: true
                    blurMax: 8
                    blur: 8
                    colorization: 1.0
                    colorizationColor: "#3498db"
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
            onClicked: {
                settingsButton.scale = 0.9
                settingsTimer.start()
            }

            Timer {
                id: settingsTimer
                interval: 100
                onTriggered: {
                    settingsButton.scale = 1.0
                    mainMenu.openSettings()
                }
            }
        }

        // Credits button
        Button {
            id: creditsButton
            width: 300
            height: 60
            text: "Credits"
            font.pixelSize: 24
            font.bold: true

            background: Rectangle {
                color: creditsButton.pressed ? "#2980b9" : "#3498db"
                radius: 10

                // Glow effect
                MultiEffect {
                    anchors.fill: parent
                    source: parent
                    blurEnabled: true
                    blurMax: 8
                    blur: 8
                    colorization: 1.0
                    colorizationColor: "#3498db"
                }
            }

            contentItem: Text {
                text: creditsButton.text
                font: creditsButton.font
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // Hover animation
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        creditsButton.scale = 1.1
                    } else {
                        creditsButton.scale = 1.0
                    }
                }
            }

            // Click animation
            onClicked: {
                creditsButton.scale = 0.9
                creditsTimer.start()
            }

            Timer {
                id: creditsTimer
                interval: 100
                onTriggered: {
                    creditsButton.scale = 1.0
                    mainMenu.openCredits()
                }
            }
        }

        // Quit button
        Button {
            id: quitButton
            width: 300
            height: 60
            text: "Quit"
            font.pixelSize: 24
            font.bold: true

            background: Rectangle {
                color: quitButton.pressed ? "#c0392b" : "#e74c3c"
                radius: 10

                // Glow effect
                MultiEffect {
                    anchors.fill: parent
                    source: parent
                    blurEnabled: true
                    blurMax: 8
                    blur: 8
                    colorization: 1.0
                    colorizationColor: "#e74c3c"
                }
            }

            contentItem: Text {
                text: quitButton.text
                font: quitButton.font
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // Hover animation
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        quitButton.scale = 1.1
                    } else {
                        quitButton.scale = 1.0
                    }
                }
            }

            // Click animation
            onClicked: {
                quitButton.scale = 0.9
                quitTimer.start()
            }

            Timer {
                id: quitTimer
                interval: 100
                onTriggered: {
                    quitButton.scale = 1.0
                    mainMenu.quitGame()
                }
            }
        }
    }

    // Version text
    Text {
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 20
        }
        text: "Version 1.0.0"
        color: "#ffffff"
        font.pixelSize: 16
        opacity: 0.7
    }

    // Signals
    signal startGame()
    signal openLevelSelect()
    signal openSettings()
    signal openCredits()
    signal quitGame()
} 