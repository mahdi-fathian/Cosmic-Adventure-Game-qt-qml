import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtGraphicalEffects

Rectangle {
    id: gameScene
    color: "#000000"

    // Game properties
    property int score: 0
    property int lives: 3
    property int level: 1
    property bool isGameOver: false
    property bool isPaused: false
    property int coins: 0
    property int powerUps: 0
    property int targetScore: 1000
    property bool isLevelComplete: false

    // Background with parallax effect
    Image {
        id: gameBackground
        anchors.fill: parent
        source: "qrc:/assets/images/background.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.8

        // Parallax effect
        property real offset: 0
        NumberAnimation on offset {
            from: 0
            to: 100
            duration: 20000
            loops: Animation.Infinite
            running: !isPaused && !isGameOver
        }
    }

    // Player with animation
    Rectangle {
        id: player
        width: 50
        height: 50
        color: "#4a90e2"
        radius: 25
        x: parent.width / 2 - width / 2
        y: parent.height - height - 100

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: "#4a90e2"
            radius: 8
            samples: 17
        }

        // Physics
        property real velocityY: 0
        property real gravity: 0.5
        property bool isJumping: false
        property bool isMovingLeft: false
        property bool isMovingRight: false

        // Movement animations
        SequentialAnimation {
            id: jumpAnimation
            running: player.isJumping
            NumberAnimation {
                target: player
                property: "scale"
                to: 1.2
                duration: 200
            }
            NumberAnimation {
                target: player
                property: "scale"
                to: 1.0
                duration: 200
            }
        }

        // Horizontal movement
        Keys.onLeftPressed: {
            isMovingLeft = true
            isMovingRight = false
        }
        Keys.onRightPressed: {
            isMovingRight = true
            isMovingLeft = false
        }
        Keys.onReleased: function(event) {
            if (event.key === Qt.Key_Left) isMovingLeft = false
            if (event.key === Qt.Key_Right) isMovingRight = false
        }
        Keys.onSpacePressed: {
            if (!isJumping) {
                velocityY = -15
                isJumping = true
                jumpSound.play()
                jumpAnimation.start()
            }
        }

        // Update position
        Timer {
            running: true
            repeat: true
            interval: 16
            onTriggered: {
                // Horizontal movement
                if (isMovingLeft && x > 0) x -= 5
                if (isMovingRight && x < parent.width - width) x += 5

                // Apply gravity
                player.velocityY += player.gravity
                player.y += player.velocityY

                // Collision with ground
                if (player.y > parent.height - player.height) {
                    player.y = parent.height - player.height
                    player.velocityY = 0
                    player.isJumping = false
                }

                // Check platform collisions
                for (var i = 0; i < platformsRepeater.count; i++) {
                    var platform = platformsRepeater.itemAt(i)
                    if (platform && player.checkCollision(platform)) {
                        if (player.velocityY > 0) {
                            player.y = platform.y - player.height
                            player.velocityY = 0
                            player.isJumping = false
                        }
                    }
                }
            }
        }

        // Collision detection
        function checkCollision(other) {
            return x < other.x + other.width &&
                   x + width > other.x &&
                   y < other.y + other.height &&
                   y + height > other.y
        }
    }

    // Platforms with animation
    Repeater {
        id: platformsRepeater
        model: 5
        Rectangle {
            width: 100
            height: 20
            color: "#2ecc71"
            radius: 5
            x: Math.random() * (parent.width - width)
            y: Math.random() * (parent.height - 200) + 100

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                color: "#2ecc71"
                radius: 4
                samples: 9
            }

            // Floating animation
            SequentialAnimation {
                running: true
                loops: Animation.Infinite
                NumberAnimation {
                    target: parent
                    property: "y"
                    to: parent.y + 10
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: parent
                    property: "y"
                    to: parent.y - 10
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    // Stars with animation
    Repeater {
        id: starsRepeater
        model: 10
        Rectangle {
            width: 20
            height: 20
            color: "#f1c40f"
            radius: 10
            x: Math.random() * (parent.width - width)
            y: Math.random() * (parent.height - 200) + 100

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                color: "#f1c40f"
                radius: 8
                samples: 17
            }

            // Rotation animation
            RotationAnimation {
                target: parent
                property: "rotation"
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
                running: true
            }

            // Collection animation
            SequentialAnimation {
                id: collectAnimation
                running: false
                NumberAnimation {
                    target: parent
                    property: "scale"
                    to: 1.5
                    duration: 200
                }
                NumberAnimation {
                    target: parent
                    property: "opacity"
                    to: 0
                    duration: 200
                }
            }

            function collect() {
                collectAnimation.start()
                score += 10
                collectSound.play()
                
                // Check for level completion
                if (score >= targetScore) {
                    isLevelComplete = true
                    levelCompleteDialog.open()
                }
            }
        }
    }

    // Enemies
    Repeater {
        model: 5
        Enemy {
            x: Math.random() * (parent.width - width)
            y: Math.random() * (parent.height - height)
            type: Math.floor(Math.random() * 3)
        }
    }

    // Coins
    Repeater {
        model: 20
        Rectangle {
            width: 24
            height: 24
            radius: 12
            color: "#FFD700"
            x: Math.random() * (parent.width - width)
            y: Math.random() * (parent.height - height)

            // Rotation animation
            RotationAnimation {
                target: parent
                property: "rotation"
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
            }

            // Collection effect
            SequentialAnimation {
                id: collectAnimation
                running: false
                NumberAnimation {
                    target: parent
                    property: "scale"
                    to: 1.5
                    duration: 200
                }
                NumberAnimation {
                    target: parent
                    property: "opacity"
                    to: 0
                    duration: 200
                }
            }

            function collect() {
                collectAnimation.start()
                coins++
                score += 10
            }
        }
    }

    // Power-ups
    Repeater {
        model: 3
        Rectangle {
            width: 32
            height: 32
            radius: 16
            color: "#FF00FF"
            x: Math.random() * (parent.width - width)
            y: Math.random() * (parent.height - height)

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                color: "#FF00FF"
                radius: 8
                samples: 17
            }

            // Pulse animation
            SequentialAnimation {
                running: true
                loops: Animation.Infinite
                NumberAnimation {
                    target: parent
                    property: "scale"
                    to: 1.2
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: parent
                    property: "scale"
                    to: 1.0
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }

            function collect() {
                powerUps++
                score += 50
                destroy()
            }
        }
    }

    // HUD with effects
    Rectangle {
        id: hud
        anchors.fill: parent
        color: "transparent"

        // Score display with animation
        Text {
            id: scoreText
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 20
            text: "Score: " + score
            color: "#ffffff"
            font.pixelSize: 32
            font.bold: true

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                color: "#4a90e2"
                radius: 4
                samples: 9
            }

            // Score change animation
            SequentialAnimation {
                id: scoreAnimation
                running: false
                NumberAnimation {
                    target: scoreText
                    property: "scale"
                    to: 1.2
                    duration: 200
                }
                NumberAnimation {
                    target: scoreText
                    property: "scale"
                    to: 1.0
                    duration: 200
                }
            }
        }

        // Lives display
        Row {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20
            spacing: 10

            Repeater {
                model: lives
                Rectangle {
                    width: 30
                    height: 30
                    color: "#e74c3c"
                    radius: 15

                    // Pulse animation
                    SequentialAnimation {
                        running: true
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: parent
                            property: "scale"
                            to: 1.1
                            duration: 1000
                            easing.type: Easing.InOutQuad
                        }
                        NumberAnimation {
                            target: parent
                            property: "scale"
                            to: 1.0
                            duration: 1000
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }

        // Level display
        Text {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 20
            text: "Level " + level
            color: "#ffffff"
            font.pixelSize: 32
            font.bold: true

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                color: "#4a90e2"
                radius: 4
                samples: 9
            }
        }

        // Target score display
        Text {
            anchors.top: scoreText.bottom
            anchors.right: parent.right
            anchors.margins: 10
            text: "Target: " + targetScore
            color: "#ffffff"
            font.pixelSize: 24
            opacity: 0.8
        }
    }

    // Level complete dialog
    Dialog {
        id: levelCompleteDialog
        title: "Level Complete!"
        modal: true
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        width: 400
        height: 300

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Text {
                text: "Congratulations!"
                color: "#4a90e2"
                font.pixelSize: 32
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "You completed level " + level
                color: "#ffffff"
                font.pixelSize: 24
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Score: " + score
                color: "#ffffff"
                font.pixelSize: 24
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: "Next Level"
                font.pixelSize: 24
                Layout.preferredWidth: 300
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "#4a90e2"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: parent.font
                }
                onClicked: {
                    level++
                    targetScore = level * 1000
                    score = 0
                    // Add more platforms and stars
                    for (var i = 0; i < 2; i++) {
                        platformsRepeater.model++
                        starsRepeater.model++
                    }
                    levelCompleteDialog.close()
                }
            }
        }
    }

    // Pause menu with effects
    Rectangle {
        id: pauseMenu
        anchors.fill: parent
        color: "#80000000"
        visible: isPaused

        // Blur effect
        FastBlur {
            anchors.fill: parent
            source: gameBackground
            radius: 32
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: "Game Paused"
                color: "#ffffff"
                font.pixelSize: 48
                font.bold: true
                Layout.alignment: Qt.AlignHCenter

                // Glow effect
                layer.enabled: true
                layer.effect: Glow {
                    color: "#4a90e2"
                    radius: 8
                    samples: 17
                }
            }

            Button {
                text: "Resume"
                font.pixelSize: 24
                Layout.preferredWidth: 300
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "#4a90e2"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: parent.font
                }
                onClicked: isPaused = false
            }

            Button {
                text: "Settings"
                font.pixelSize: 24
                Layout.preferredWidth: 300
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "#4a90e2"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: parent.font
                }
            }

            Button {
                text: "Main Menu"
                font.pixelSize: 24
                Layout.preferredWidth: 300
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "#4a90e2"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: parent.font
                }
                onClicked: stackView.pop()
            }
        }
    }

    // Game over overlay with effects
    Rectangle {
        id: gameOverOverlay
        anchors.fill: parent
        color: "#80000000"
        visible: isGameOver

        // Blur effect
        FastBlur {
            anchors.fill: parent
            source: gameBackground
            radius: 32
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: "Game Over"
                color: "#e74c3c"
                font.pixelSize: 72
                font.bold: true
                Layout.alignment: Qt.AlignHCenter

                // Glow effect
                layer.enabled: true
                layer.effect: Glow {
                    color: "#e74c3c"
                    radius: 8
                    samples: 17
                }
            }

            Text {
                text: "Final Score: " + score
                color: "#ffffff"
                font.pixelSize: 36
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Level Reached: " + level
                color: "#ffffff"
                font.pixelSize: 24
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: "Play Again"
                font.pixelSize: 24
                Layout.preferredWidth: 300
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "#4a90e2"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: parent.font
                }
                onClicked: {
                    isGameOver = false
                    score = 0
                    lives = 3
                    level = 1
                    targetScore = 1000
                    player.x = parent.width / 2 - player.width / 2
                    player.y = parent.height - player.height - 100
                    player.velocityY = 0
                    player.isJumping = false
                }
            }

            Button {
                text: "Main Menu"
                font.pixelSize: 24
                Layout.preferredWidth: 300
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "#4a90e2"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: parent.font
                }
                onClicked: stackView.pop()
            }
        }
    }

    // Sound effects
    SoundEffect {
        id: jumpSound
        source: "qrc:/assets/sounds/jump.wav"
    }

    SoundEffect {
        id: collectSound
        source: "qrc:/assets/sounds/collect.wav"
    }

    // Background music
    MediaPlayer {
        id: backgroundMusic
        source: "qrc:/assets/sounds/background.mp3"
        loops: MediaPlayer.Infinite
        volume: 0.5
    }

    // Keyboard input handling
    Keys.onPressed: function(event) {
        if (event.key === Qt.Key_Escape) {
            isPaused = !isPaused
        }
    }

    // Focus handling
    Component.onCompleted: {
        forceActiveFocus()
        backgroundMusic.play()
    }

    // Collision detection timer
    Timer {
        interval: 16
        running: !isPaused && !isGameOver
        repeat: true
        onTriggered: {
            // Check for star collection
            for (var i = 0; i < starsRepeater.count; i++) {
                var star = starsRepeater.itemAt(i)
                if (star && player.checkCollision(star)) {
                    star.collect()
                    scoreAnimation.start()
                }
            }

            // Check for falling off the screen
            if (player.y > parent.height) {
                lives--
                if (lives <= 0) {
                    isGameOver = true
                    backgroundMusic.stop()
                } else {
                    // Reset player position
                    player.x = parent.width / 2 - player.width / 2
                    player.y = parent.height - player.height - 100
                    player.velocityY = 0
                    player.isJumping = false
                }
            }
        }
    }

    // Back button with effect
    Button {
        text: "بازگشت به منو"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        background: Rectangle {
            color: "#4a90e2"
            radius: 10
        }
        contentItem: Text {
            text: parent.text
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 18
        }
        onClicked: {
            backgroundMusic.stop()
            stackView.pop()
        }
    }

    // Enable keyboard controls
    focus: true
    Keys.enabled: true
} 