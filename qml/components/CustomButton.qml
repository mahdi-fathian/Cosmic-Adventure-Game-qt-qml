import QtQuick
import QtQuick.Controls

Button {
    id: control
    width: Theme.buttonWidth
    height: Theme.buttonHeight

    property color buttonColor: Theme.primaryColor
    property color hoverColor: Qt.lighter(buttonColor, 1.2)
    property color pressColor: Qt.darker(buttonColor, 1.2)
    property bool isAccent: false

    contentItem: Text {
        text: control.text
        font: Theme.buttonFont
        color: Theme.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        id: buttonBackground
        radius: Theme.cornerRadius
        gradient: isAccent ? Theme.accentGradient : Theme.primaryGradient

        // Glow effect
        layer.enabled: true
        layer.effect: isAccent ? Theme.accentGlow : Theme.standardGlow

        // Hover effect
        states: [
            State {
                name: "hovered"
                when: control.hovered
                PropertyChanges {
                    target: buttonBackground
                    scale: 1.05
                }
            },
            State {
                name: "pressed"
                when: control.pressed
                PropertyChanges {
                    target: buttonBackground
                    scale: 0.95
                }
            }
        ]

        // Transitions
        transitions: [
            Transition {
                from: "*"; to: "*"
                NumberAnimation {
                    properties: "scale"
                    duration: Theme.animationDuration
                    easing: Theme.standardEasing
                }
            }
        ]

        // Ripple effect
        Rectangle {
            id: ripple
            width: 0
            height: 0
            radius: width / 2
            color: Qt.rgba(1, 1, 1, 0.2)
            x: control.pressed ? control.mouseX - width/2 : buttonBackground.width/2
            y: control.pressed ? control.mouseY - height/2 : buttonBackground.height/2
            opacity: 0

            property bool isAnimating: false

            function startRipple() {
                if (!isAnimating) {
                    isAnimating = true
                    width = 0
                    height = 0
                    opacity = 1
                    rippleAnimation.start()
                }
            }

            SequentialAnimation {
                id: rippleAnimation
                ParallelAnimation {
                    NumberAnimation {
                        target: ripple
                        property: "width"
                        to: Math.max(buttonBackground.width, buttonBackground.height) * 2
                        duration: Theme.animationDuration
                        easing: Theme.standardEasing
                    }
                    NumberAnimation {
                        target: ripple
                        property: "height"
                        to: Math.max(buttonBackground.width, buttonBackground.height) * 2
                        duration: Theme.animationDuration
                        easing: Theme.standardEasing
                    }
                }
                NumberAnimation {
                    target: ripple
                    property: "opacity"
                    to: 0
                    duration: Theme.animationDuration
                    easing: Theme.standardEasing
                }
                ScriptAction {
                    script: ripple.isAnimating = false
                }
            }
        }
    }

    // Mouse area for ripple effect
    MouseArea {
        anchors.fill: parent
        onClicked: {
            ripple.startRipple()
            control.clicked()
        }
    }

    // Hover sound effect
    SoundEffect {
        id: hoverSound
        source: "qrc:/assets/sounds/hover.wav"
        volume: 0.3
    }

    // Click sound effect
    SoundEffect {
        id: clickSound
        source: "qrc:/assets/sounds/click.wav"
        volume: 0.5
    }

    // Hover and click handlers
    onHoveredChanged: {
        if (hovered) {
            hoverSound.play()
        }
    }

    onClicked: {
        clickSound.play()
    }
} 