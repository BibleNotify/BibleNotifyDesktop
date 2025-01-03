import sys
import assets.assets_qrc
import biblenotify.biblenotify_qrc
import translations.translations_qrc

from PySide6.QtCore import QLibraryInfo, QLocale, QTranslator
from PySide6.QtGui import QGuiApplication, QIcon
from PySide6.QtQml import QQmlEngine, QQmlApplicationEngine
from PySide6.QtWidgets import QApplication, QSystemTrayIcon
from PySide6.QtQuickControls2 import QQuickStyle

from biblenotify import Loader, Notifications


if __name__ == "__main__":
    # NOTE: This *has* to be QGuiApplication otherwise the system tray right-click menu won't show
    app = QGuiApplication(sys.argv)

    QQuickStyle.setStyle("Basic")

    # TODO: Move the translation code to another file
    # Load the translations shipped with Qt
    translator = QTranslator(app)
    path = QLibraryInfo.path(QLibraryInfo.TranslationsPath)
    if translator.load(QLocale.system(), "qtbase", "_", path):
        app.installTranslator(translator)

    # Load Bible Notify's translations
    translator = QTranslator(app)
    path = ":/translations"
    if translator.load(QLocale.system(), "biblenotify", "_", path):
        app.installTranslator(translator)

    app.setQuitOnLastWindowClosed(False)
    app.setApplicationName("Bible Notify")
    app.setApplicationVersion("0.1")
    app.setWindowIcon(QIcon(":/icon.svg"))

    engine = QQmlApplicationEngine()
    engine.addImportPath(":/ui")

    # TODO: Surely there is a better name for this class
    # TODO: Why doesn't this work when the notifications class does?
    loader = Loader()
    engine.rootContext().setContextProperty("Loader", loader)

    notifications = Notifications()
    # TODO: Should this be something other than a context property?
    engine.rootContext().setContextProperty("Notifications", notifications)

    engine.quit.connect(app.quit)
    engine.load("qrc:/ui/main.qml")

    sys.exit(app.exec())
