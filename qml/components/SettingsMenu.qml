import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: settingsMenu
    anchors.fill: parent

    // Background
    Background {
        anchors.fill: parent
    }

    // Settings container
    Rectangle {
        id: settingsContainer
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
            text: "Settings"
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

        // Settings content
        Column {
            anchors.centerIn: parent
            spacing: 30

            // Sound settings
            Column {
                spacing: 10

                Text {
                    text: "Sound"
                    font.pixelSize: 20
                    font.bold: true
                    color: "#ffffff"
                }

                // Sound toggle
                Row {
                    spacing: 20

                    Text {
                        text: "Sound Effects"
                        font.pixelSize: 16
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Switch {
                        id: soundSwitch
                        checked: true

                        indicator: Rectangle {
                            implicitWidth: 48
                            implicitHeight: 24
                            radius: 12
                            color: soundSwitch.checked ? "#2ecc71" : "#95a5a6"
                            border.color: soundSwitch.checked ? "#27ae60" : "#7f8c8d"

                            Rectangle {
                                x: soundSwitch.checked ? parent.width - width : 0
                                width: 20
                                height: 20
                                radius: 10
                                color: "#ffffff"
                                border.color: "#bdc3c7"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.margins: 2

                                Behavior on x {
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.OutQuad
                                    }
                                }
                            }
                        }
                    }
                }

                // Music toggle
                Row {
                    spacing: 20

                    Text {
                        text: "Background Music"
                        font.pixelSize: 16
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Switch {
                        id: musicSwitch
                        checked: true

                        indicator: Rectangle {
                            implicitWidth: 48
                            implicitHeight: 24
                            radius: 12
                            color: musicSwitch.checked ? "#2ecc71" : "#95a5a6"
                            border.color: musicSwitch.checked ? "#27ae60" : "#7f8c8d"

                            Rectangle {
                                x: musicSwitch.checked ? parent.width - width : 0
                                width: 20
                                height: 20
                                radius: 10
                                color: "#ffffff"
                                border.color: "#bdc3c7"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.margins: 2

                                Behavior on x {
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.OutQuad
                                    }
                                }
                            }
                        }
                    }
                }

                // Volume slider
                Column {
                    spacing: 5

                    Text {
                        text: "Volume"
                        font.pixelSize: 16
                        color: "#ffffff"
                    }

                    Slider {
                        id: volumeSlider
                        width: 300
                        from: 0
                        to: 100
                        value: 50

                        background: Rectangle {
                            x: volumeSlider.leftPadding
                            y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                            width: volumeSlider.availableWidth
                            height: 4
                            radius: 2
                            color: "#95a5a6"

                            Rectangle {
                                width: volumeSlider.visualPosition * parent.width
                                height: parent.height
                                color: "#2ecc71"
                                radius: 2
                            }
                        }

                        handle: Rectangle {
                            x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                            y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                            width: 20
                            height: 20
                            radius: 10
                            color: "#ffffff"
                            border.color: "#bdc3c7"

                            // Glow effect
                            layer.enabled: true
                            layer.effect: Glow {
                                color: "#2ecc71"
                                radius: 8
                                samples: 17
                                transparentBorder: true
                            }
                        }
                    }
                }
            }

            // Graphics settings
            Column {
                spacing: 10

                Text {
                    text: "Graphics"
                    font.pixelSize: 20
                    font.bold: true
                    color: "#ffffff"
                }

                // Quality selector
                Column {
                    spacing: 5

                    Text {
                        text: "Quality"
                        font.pixelSize: 16
                        color: "#ffffff"
                    }

                    ComboBox {
                        id: qualityComboBox
                        width: 200
                        model: ["Low", "Medium", "High", "Ultra"]
                        currentIndex: 2

                        background: Rectangle {
                            color: "#2c3e50"
                            radius: 5
                        }

                        contentItem: Text {
                            text: qualityComboBox.displayText
                            font.pixelSize: 16
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 10
                        }

                        indicator: Rectangle {
                            width: 20
                            height: 20
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            color: "transparent"

                            Rectangle {
                                width: 8
                                height: 8
                                anchors.centerIn: parent
                                color: "#ffffff"
                                rotation: 45
                                transform: Rotation {
                                    origin.x: 4
                                    origin.y: 4
                                    angle: qualityComboBox.popup.visible ? 180 : 0
                                }
                            }
                        }

                        popup: Popup {
                            y: qualityComboBox.height
                            width: qualityComboBox.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1

                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: qualityComboBox.popup.visible ? qualityComboBox.delegateModel : null
                                currentIndex: qualityComboBox.highlightedIndex

                                ScrollIndicator.vertical: ScrollIndicator {}
                            }

                            background: Rectangle {
                                color: "#2c3e50"
                                radius: 5
                            }
                        }

                        delegate: ItemDelegate {
                            width: qualityComboBox.width
                            contentItem: Text {
                                text: modelData
                                font.pixelSize: 16
                                color: "#ffffff"
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: 10
                            }
                            highlighted: qualityComboBox.highlightedIndex === index
                            background: Rectangle {
                                color: highlighted ? "#34495e" : "transparent"
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
                text: "Back"
                font.pixelSize: 20
                font.bold: true

                background: Rectangle {
                    color: backButton.pressed ? "#e74c3c" : "#c0392b"
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
                SequentialAnimation {
                    id: backClickAnimation
                    NumberAnimation {
                        target: backButton
                        property: "scale"
                        to: 0.9
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: backButton
                        property: "scale"
                        to: 1.0
                        duration: 100
                        easing.type: Easing.InQuad
                    }
                }

                onClicked: {
                    backClickAnimation.start()
                    // Emit signal to go back
                    settingsMenu.goBack()
                }
            }
        }
    }

    // Signals
    signal goBack()
} 