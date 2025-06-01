#include "gameengine.h"
#include <QDebug>

GameEngine::GameEngine(QObject *parent)
    : QObject(parent)
    , m_score(0)
    , m_isGameOver(false)
{
    m_gameTimer = new QTimer(this);
    connect(m_gameTimer, &QTimer::timeout, this, &GameEngine::checkCollisions);
}

GameEngine::~GameEngine()
{
    if (m_gameTimer->isActive()) {
        m_gameTimer->stop();
    }
}

void GameEngine::startGame()
{
    m_score = 0;
    m_isGameOver = false;
    emit scoreChanged(m_score);
    emit gameOverChanged(m_isGameOver);
    m_gameTimer->start(16); // ~60 FPS
}

void GameEngine::pauseGame()
{
    if (m_gameTimer->isActive()) {
        m_gameTimer->stop();
    }
}

void GameEngine::resumeGame()
{
    if (!m_gameTimer->isActive() && !m_isGameOver) {
        m_gameTimer->start(16);
    }
}

void GameEngine::resetGame()
{
    m_score = 0;
    m_isGameOver = false;
    emit scoreChanged(m_score);
    emit gameOverChanged(m_isGameOver);
    m_gameTimer->start(16);
}

void GameEngine::updateScore(int points)
{
    m_score += points;
    emit scoreChanged(m_score);
}

void GameEngine::checkCollisions()
{
    // This function will be called by QML to check collisions
    // The actual collision detection is handled in the QML components
    // This is just a placeholder for any additional game logic
    if (m_score >= 1000) {
        m_isGameOver = true;
        emit gameOverChanged(m_isGameOver);
        m_gameTimer->stop();
    }
} 