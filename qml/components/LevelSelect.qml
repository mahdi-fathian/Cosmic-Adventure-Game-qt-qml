import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: levelSelect
    anchors.fill: parent

    // Properties
    property bool isActive: true
    property int currentLevel: 1
    property int maxLevel: 10
    property var levelStars: ({}) // Map of level number to stars earned

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

    // Level select container
    Rectangle {
        id: levelSelectContainer
        width: 800
        height: 600
        anchors.centerIn: parent
        color: "#1a1a1a"
        radius: 20
        opacity: 0.9

        // Blur effect
        GaussianBlur {
            anchors.fill: levelSelectContainer
            source: levelSelectContainer
            radius: 10
            samples: 25
        }

        // Border glow
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            border.color: "#3498db"
            border.width: 2

            // Glow effect
            Glow {
                anchors.fill: parent
                radius: 8
                samples: 17
                color: "#3498db"
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
            text: "Select Level"
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
                color: "#3498db"
                source: titleText
            }
        }

        // Level grid
        Grid {
            anchors {
                top: titleText.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 40
            }
            columns: 5
            spacing: 20

            Repeater {
                model: maxLevel

                // Level button
                Rectangle {
                    id: levelButton
                    width: 120
                    height: 120
                    radius: 10
                    color: modelData + 1 <= currentLevel ? "#3498db" : "#4a4a4a"
                    opacity: 0.9

                    // Glow effect
                    Glow {
                        anchors.fill: levelButton
                        radius: 8
                        samples: 17
                        color: "#3498db"
                        source: levelButton
                        visible: modelData + 1 <= currentLevel
                    }

                    // Level number
                    Text {
                        anchors.centerIn: parent
                        text: modelData + 1
                        color: "#ffffff"
                        font.pixelSize: 32
                        font.bold: true
                        style: Text.Outline
                        styleColor: "#000000"
                    }

                    // Stars
                    Row {
                        anchors {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                            bottomMargin: 10
                        }
                        spacing: 5

                        Repeater {
                            model: 3
                            Rectangle {
                                width: 15
                                height: 15
                                radius: width / 2
                                color: index < (levelStars[modelData + 1] || 0) ? "#f1c40f" : "#4a4a4a"
                                opacity: 0.8

                                // Star glow
                                Glow {
                                    anchors.fill: parent
                                    radius: 4
                                    samples: 9
                                    color: "#f1c40f"
                                    source: parent
                                    visible: index < (levelStars[modelData + 1] || 0)
                                }
                            }
                        }
                    }

                    // Hover animation
                    HoverHandler {
                        onHoveredChanged: {
                            if (hovered && modelData + 1 <= currentLevel) {
                                levelButton.scale = 1.1
                            } else {
                                levelButton.scale = 1.0
                            }
                        }
                    }

                    // Click animation
                    MouseArea {
                        anchors.fill: parent
                        enabled: modelData + 1 <= currentLevel
                        onClicked: {
                            levelButton.scale = 0.9
                            levelTimer.start()
                        }
                    }

                    Timer {
                        id: levelTimer
                        interval: 100
                        onTriggered: {
                            levelButton.scale = 1.0
                            levelSelect.selectLevel(modelData + 1)
                        }
                    }
                }
            }
        }

        // Back button
        Button {
            id: backButton
            width: 200
            height: 50
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 40
            }
            text: "Back"
            font.pixelSize: 20
            font.bold: true

            background: Rectangle {
                color: backButton.pressed ? "#2980b9" : "#3498db"
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
                text: backButton.text
                font: backButton.font
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // Hover animation
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        backButton.scale = 1.1
                    } else {
                        backButton.scale = 1.0
                    }
                }
            }

            // Click animation
            onClicked: {
                backButton.scale = 0.9
                backTimer.start()
            }

            Timer {
                id: backTimer
                interval: 100
                onTriggered: {
                    backButton.scale = 1.0
                    levelSelect.goBack()
                }
            }
        }
    }

    // Signals
    signal selectLevel(int level)
    signal goBack()
} 