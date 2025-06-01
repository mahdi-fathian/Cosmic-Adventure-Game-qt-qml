import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    anchors.fill: parent

    // Properties
    property real volume: 0.5
    property bool musicEnabled: true
    property bool soundEnabled: true
    property int graphicsQuality: 2 // 0: Low, 1: Medium, 2: High, 3: Ultra

    // Background overlay
    Rectangle {
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

    // Settings container
    Rectangle {
        id: settingsContainer
        anchors.centerIn: parent
        width: 500
        height: settingsColumn.height + 40
        color: "#1A000000"
        radius: 10

        // Blur effect
        MultiEffect {
            anchors.fill: parent
            source: parent
            blurEnabled: true
            blurMax: 8
            blur: 8
        }

        // Settings content
        Column {
            id: settingsColumn
            anchors {
                centerIn: parent
                verticalCenterOffset: -20
            }
            spacing: 20

            // Title
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Settings"
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

            // Volume slider
            Column {
                width: 400
                spacing: 10

                Text {
                    text: "Volume"
                    color: "#ffffff"
                    font.pixelSize: 20
                    font.bold: true
                }

                Rectangle {
                    width: parent.width
                    height: 40
                    radius: 20
                    color: "#2c3e50"

                    Rectangle {
                        id: volumeFill
                        width: parent.width * root.volume
                        height: parent.height
                        radius: parent.radius
                        color: "#3498db"

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

                    Text {
                        anchors.centerIn: parent
                        text: Math.round(root.volume * 100) + "%"
                        color: "#ffffff"
                        font.pixelSize: 16
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.volume = mouseX / parent.width
                        }
                    }
                }
            }

            // Music toggle
            Row {
                width: 400
                spacing: 20

                Text {
                    text: "Music"
                    color: "#ffffff"
                    font.pixelSize: 20
                    font.bold: true
                }

                Rectangle {
                    width: 60
                    height: 30
                    radius: 15
                    color: root.musicEnabled ? "#2ecc71" : "#e74c3c"

                    // Glow effect
                    MultiEffect {
                        anchors.fill: parent
                        source: parent
                        blurEnabled: true
                        blurMax: 8
                        blur: 8
                        colorization: 1.0
                        colorizationColor: parent.color
                    }

                    Rectangle {
                        width: 26
                        height: 26
                        radius: 13
                        color: "#ffffff"
                        x: root.musicEnabled ? parent.width - width - 2 : 2
                        y: 2

                        Behavior on x {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutQuad
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.musicEnabled = !root.musicEnabled
                        }
                    }
                }
            }

            // Sound toggle
            Row {
                width: 400
                spacing: 20

                Text {
                    text: "Sound"
                    color: "#ffffff"
                    font.pixelSize: 20
                    font.bold: true
                }

                Rectangle {
                    width: 60
                    height: 30
                    radius: 15
                    color: root.soundEnabled ? "#2ecc71" : "#e74c3c"

                    // Glow effect
                    MultiEffect {
                        anchors.fill: parent
                        source: parent
                        blurEnabled: true
                        blurMax: 8
                        blur: 8
                        colorization: 1.0
                        colorizationColor: parent.color
                    }

                    Rectangle {
                        width: 26
                        height: 26
                        radius: 13
                        color: "#ffffff"
                        x: root.soundEnabled ? parent.width - width - 2 : 2
                        y: 2

                        Behavior on x {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutQuad
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.soundEnabled = !root.soundEnabled
                        }
                    }
                }
            }

            // Graphics quality
            Column {
                width: 400
                spacing: 10

                Text {
                    text: "Graphics Quality"
                    color: "#ffffff"
                    font.pixelSize: 20
                    font.bold: true
                }

                ComboBox {
                    id: graphicsComboBox
                    width: parent.width
                    height: 40
                    model: ["Low", "Medium", "High", "Ultra"]
                    currentIndex: root.graphicsQuality

                    background: Rectangle {
                        color: "#2c3e50"
                        radius: 5

                        // Glow effect
                        MultiEffect {
                            anchors.fill: parent
                            source: parent
                            blurEnabled: true
                            blurMax: 8
                            blur: 8
                            colorization: 1.0
                            colorizationColor: "#2c3e50"
                        }
                    }

                    contentItem: Text {
                        text: graphicsComboBox.displayText
                        color: "#ffffff"
                        font.pixelSize: 16
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }

                    onCurrentIndexChanged: {
                        root.graphicsQuality = currentIndex
                    }
                }
            }

            // Back button
            Rectangle {
                width: 300
                height: 50
                radius: 10
                color: backMouseArea.containsMouse ? "#2980b9" : "#3498db"

                // Glow effect
                MultiEffect {
                    anchors.fill: parent
                    source: parent
                    blurEnabled: true
                    blurMax: 8
                    blur: 8
                    colorization: 1.0
                    colorizationColor: parent.color
                }

                Text {
                    anchors.centerIn: parent
                    text: "Back"
                    color: "#ffffff"
                    font.pixelSize: 24
                    font.bold: true
                }

                MouseArea {
                    id: backMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        backTimer.start()
                    }
                }

                Timer {
                    id: backTimer
                    interval: 100
                    onTriggered: root.back()
                }
            }
        }
    }

    // Signals
    signal back()
} 