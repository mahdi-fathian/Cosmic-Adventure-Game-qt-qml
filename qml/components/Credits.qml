import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: credits
    anchors.fill: parent

    // Properties
    property bool isActive: true

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

    // Credits container
    Rectangle {
        id: creditsContainer
        width: 600
        height: 800
        anchors.centerIn: parent
        color: "#1a1a1a"
        radius: 20
        opacity: 0.9

        // Blur effect
        GaussianBlur {
            anchors.fill: creditsContainer
            source: creditsContainer
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
            text: "Credits"
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

        // Credits content
        Flickable {
            anchors {
                top: titleText.bottom
                left: parent.left
                right: parent.right
                bottom: backButton.top
                margins: 40
            }
            contentHeight: creditsColumn.height
            clip: true

            Column {
                id: creditsColumn
                width: parent.width
                spacing: 30

                // Game title
                Text {
                    text: "Cosmic Adventure"
                    color: "#ffffff"
                    font.pixelSize: 32
                    font.bold: true
                    style: Text.Outline
                    styleColor: "#000000"
                    anchors.horizontalCenter: parent.horizontalCenter

                    // Glow effect
                    Glow {
                        anchors.fill: parent
                        radius: 8
                        samples: 17
                        color: "#3498db"
                        source: parent
                    }
                }

                // Version
                Text {
                    text: "Version 1.0.0"
                    color: "#ffffff"
                    font.pixelSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Development
                Column {
                    width: parent.width
                    spacing: 20

                    Text {
                        text: "Development"
                        color: "#3498db"
                        font.pixelSize: 24
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Game Design & Programming"
                        color: "#ffffff"
                        font.pixelSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Your Name"
                        color: "#ffffff"
                        font.pixelSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                // Art
                Column {
                    width: parent.width
                    spacing: 20

                    Text {
                        text: "Art"
                        color: "#3498db"
                        font.pixelSize: 24
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Graphics & Animation"
                        color: "#ffffff"
                        font.pixelSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Your Name"
                        color: "#ffffff"
                        font.pixelSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                // Music
                Column {
                    width: parent.width
                    spacing: 20

                    Text {
                        text: "Music"
                        color: "#3498db"
                        font.pixelSize: 24
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Sound Design & Music"
                        color: "#ffffff"
                        font.pixelSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Your Name"
                        color: "#ffffff"
                        font.pixelSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                // Special thanks
                Column {
                    width: parent.width
                    spacing: 20

                    Text {
                        text: "Special Thanks"
                        color: "#3498db"
                        font.pixelSize: 24
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "To all the amazing people who supported this project"
                        color: "#ffffff"
                        font.pixelSize: 18
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        width: parent.width - 40
                    }
                }

                // Copyright
                Text {
                    text: "© 2024 Your Company. All rights reserved."
                    color: "#ffffff"
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
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
                    credits.goBack()
                }
            }
        }
    }

    // Signals
    signal goBack()
} 