#ifndef GAMEENGINE_H
#define GAMEENGINE_H

#include <QObject>
#include <QTimer>
#include <QVector>
#include <QString>

class GameEngine : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int score READ score NOTIFY scoreChanged)
    Q_PROPERTY(int highScore READ highScore NOTIFY highScoreChanged)
    Q_PROPERTY(int lives READ lives NOTIFY livesChanged)
    Q_PROPERTY(int level READ level NOTIFY levelChanged)
    Q_PROPERTY(bool isGameOver READ isGameOver NOTIFY gameOverChanged)
    Q_PROPERTY(bool isPaused READ isPaused NOTIFY pauseChanged)
    Q_PROPERTY(QString playerName READ playerName WRITE setPlayerName NOTIFY playerNameChanged)
    Q_PROPERTY(int coins READ coins NOTIFY coinsChanged)
    Q_PROPERTY(int powerUps READ powerUps NOTIFY powerUpsChanged)

public:
    explicit GameEngine(QObject *parent = nullptr);
    ~GameEngine();

    int score() const { return m_score; }
    int highScore() const { return m_highScore; }
    int lives() const { return m_lives; }
    int level() const { return m_level; }
    bool isGameOver() const { return m_isGameOver; }
    bool isPaused() const { return m_isPaused; }
    QString playerName() const { return m_playerName; }
    int coins() const { return m_coins; }
    int powerUps() const { return m_powerUps; }

    void setPlayerName(const QString &name) {
        if (m_playerName != name) {
            m_playerName = name;
            emit playerNameChanged(name);
        }
    }

public slots:
    void startGame();
    void pauseGame();
    void resumeGame();
    void resetGame();
    void updateScore(int points);
    void checkCollisions();
    void collectCoin();
    void collectPowerUp();
    void loseLife();
    void nextLevel();
    void usePowerUp();
    void saveGame();
    void loadGame();
    void showLeaderboard();

signals:
    void scoreChanged(int newScore);
    void highScoreChanged(int newHighScore);
    void livesChanged(int newLives);
    void levelChanged(int newLevel);
    void gameOverChanged(bool isGameOver);
    void pauseChanged(bool isPaused);
    void playerNameChanged(const QString &name);
    void coinsChanged(int newCoins);
    void powerUpsChanged(int newPowerUps);
    void platformCollision();
    void starCollected(int points);
    void levelCompleted();
    void gameWon();

private:
    int m_score;
    int m_highScore;
    int m_lives;
    int m_level;
    bool m_isGameOver;
    bool m_isPaused;
    QString m_playerName;
    int m_coins;
    int m_powerUps;
    QTimer *m_gameTimer;
    QVector<QObject*> m_platforms;
    QVector<QObject*> m_stars;
    QVector<QObject*> m_enemies;
    QVector<QObject*> m_powerUps;
};

#endif // GAMEENGINE_H 