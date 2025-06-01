import QtQuick

QtObject {
    // Colors
    readonly property color primaryColor: "#4a90e2"
    readonly property color secondaryColor: "#50e3c2"
    readonly property color accentColor: "#f5a623"
    readonly property color backgroundColor: "#1a1a2e"
    readonly property color textColor: "#ffffff"
    readonly property color errorColor: "#ff4d4d"
    readonly property color successColor: "#4cd964"

    // Gradients
    readonly property var primaryGradient: Gradient {
        GradientStop { position: 0.0; color: "#4a90e2" }
        GradientStop { position: 1.0; color: "#357abd" }
    }

    readonly property var accentGradient: Gradient {
        GradientStop { position: 0.0; color: "#f5a623" }
        GradientStop { position: 1.0; color: "#f76b1c" }
    }

    // Fonts
    readonly property font titleFont: Qt.font({
        family: "Arial",
        pixelSize: 72,
        weight: Font.Bold
    })

    readonly property font subtitleFont: Qt.font({
        family: "Arial",
        pixelSize: 36,
        weight: Font.Medium
    })

    readonly property font buttonFont: Qt.font({
        family: "Arial",
        pixelSize: 24,
        weight: Font.Medium
    })

    readonly property font textFont: Qt.font({
        family: "Arial",
        pixelSize: 18
    })

    // Animations
    readonly property int animationDuration: 300
    readonly property var standardEasing: Easing.OutQuad

    // Dimensions
    readonly property int buttonHeight: 60
    readonly property int buttonWidth: 300
    readonly property int spacing: 20
    readonly property int cornerRadius: 10

    // Effects
    readonly property var standardGlow: Glow {
        color: "#4a90e2"
        radius: 8
        samples: 17
        transparentBorder: true
    }

    readonly property var accentGlow: Glow {
        color: "#f5a623"
        radius: 8
        samples: 17
        transparentBorder: true
    }
} 