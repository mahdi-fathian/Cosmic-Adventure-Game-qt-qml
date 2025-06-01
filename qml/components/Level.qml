import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    anchors.fill: parent

    // Properties
    property int levelNumber: 1
    property bool isActive: false

    // Level container
    Rectangle {
        id: levelContainer
        anchors.centerIn: parent
        width: levelText.width + 40
        height: levelText.height + 20
        color: "#1A000000"
        radius: 10
        visible: root.isActive

        // Blur effect
        MultiEffect {
            anchors.fill: parent
            source: parent
            blurEnabled: true
            blurMax: 8
            blur: 8
        }

        // Level text
        Text {
            id: levelText
            anchors.centerIn: parent
            text: "Level " + root.levelNumber
            color: "#ffffff"
            font.pixelSize: 32
            font.bold: true
            style: Text.Outline
            styleColor: "#000000"

            // Glow effect
            MultiEffect {
                anchors.fill: parent
                source: parent
                blurEnabled: true
                blurMax: 8
                blur: 8
                colorization: 1.0
                colorizationColor: "#ffffff"
            }
        }

        // Stars
        Row {
            anchors {
                top: levelText.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 10
            }
            spacing: 10

            Repeater {
                model: 3
                Rectangle {
                    width: 20
                    height: 20
                    radius: width / 2
                    color: "#FFD700"

                    // Glow effect
                    MultiEffect {
                        anchors.fill: parent
                        source: parent
                        blurEnabled: true
                        blurMax: 8
                        blur: 8
                        colorization: 1.0
                        colorizationColor: "#FFD700"
                    }

                    // Scale animation
                    SequentialAnimation {
                        running: true
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: this
                            property: "scale"
                            from: 1.0
                            to: 1.2
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                        NumberAnimation {
                            target: this
                            property: "scale"
                            to: 1.0
                            duration: 500
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }

        // Entrance animation
        SequentialAnimation {
            id: entranceAnimation
            running: root.isActive
            NumberAnimation {
                target: levelContainer
                property: "scale"
                from: 0.0
                to: 1.0
                duration: 300
                easing.type: Easing.OutBack
            }
        }

        // Exit animation
        SequentialAnimation {
            id: exitAnimation
            running: !root.isActive
            NumberAnimation {
                target: levelContainer
                property: "scale"
                from: 1.0
                to: 0.0
                duration: 300
                easing.type: Easing.InBack
            }
            ScriptAction {
                script: root.destroy()
            }
        }
    }

    // Auto-hide timer
    Timer {
        id: autoHideTimer
        interval: 2000
        running: root.isActive
        onTriggered: root.isActive = false
    }

    // Auto-destroy timer
    Timer {
        id: autoDestroyTimer
        interval: 500
        running: !root.isActive
        onTriggered: root.destroy()
    }

    // Functions
    function showLevel(level) {
        root.levelNumber = level
        root.isActive = true
    }

    // Initialize
    Component.onCompleted: {
        if (root.levelNumber > 0) {
            root.isActive = true
        }
    }
} 