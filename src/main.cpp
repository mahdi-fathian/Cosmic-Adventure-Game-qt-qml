#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QIcon>
#include <QtQuickControls2>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    // تنظیمات برنامه
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/assets/images/player.png"));
    app.setApplicationName("Cosmic Adventure");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("Cosmic Games");
    app.setOrganizationDomain("cosmicgames.com");

    // تنظیم استایل
    QQuickStyle::setStyle("Material");

    // ایجاد موتور QML
    QQmlApplicationEngine engine;

    // Register QML modules
    engine.addImportPath(":/qml");
    engine.addImportPath(":/qml/components");

    // تنظیم مسیر اصلی QML
    const QUrl url(u"qrc:/qml/main.qml"_s);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    // بارگذاری فایل QML اصلی
    engine.load(url);

    return app.exec();
} 