import QtQuick
import QtQuick.Controls
import QtGraphicalEffects

Item {
    id: root
    width: 64
    height: 64

    property bool isActive: true
    property color explosionColor: "#FF5722"
    property real scale: 1.0

    // Explosion body
    Rectangle {
        id: explosionBody
        anchors.fill: parent
        color: explosionColor
        radius: width / 2

        // Glow effect
        layer.enabled: true
        layer.effect: Glow {
            color: explosionColor
            radius: 16
            samples: 17
            transparentBorder: true
        }
    }

    // Explosion particles
    Repeater {
        model: 8
        Rectangle {
            id: particle
            width: parent.width * 0.2
            height: parent.height * 0.2
            color: explosionColor
            radius: width / 2
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2

            // Particle animation
            ParallelAnimation {
                running: true
                NumberAnimation {
                    target: particle
                    property: "x"
                    to: parent.width / 2 - width / 2 + Math.cos(index * Math.PI / 4) * parent.width * 0.4
                    duration: 500
                    easing.type: Easing.OutQuad
                }
                NumberAnimation {
                    target: particle
                    property: "y"
                    to: parent.height / 2 - height / 2 + Math.sin(index * Math.PI / 4) * parent.height * 0.4
                    duration: 500
                    easing.type: Easing.OutQuad
                }
                NumberAnimation {
                    target: particle
                    property: "opacity"
                    to: 0
                    duration: 500
                    easing.type: Easing.OutQuad
                }
            }
        }
    }

    // Explosion animation
    SequentialAnimation {
        running: true
        NumberAnimation {
            target: root
            property: "scale"
            to: 1.5
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: root
            property: "opacity"
            to: 0
            duration: 300
            easing.type: Easing.InQuad
        }
        onFinished: root.destroy()
    }

    // Functions
    function explode() {
        isActive = false
    }

    // Initialization
    Component.onCompleted: {
        explode()
    }
} 