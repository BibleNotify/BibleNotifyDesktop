import sys
import assets.assets
import biblenotify.biblenotify

from PySide6.QtGui import QGuiApplication, QIcon
from PySide6.QtQml import QQmlEngine, QQmlApplicationEngine
from PySide6.QtWidgets import QApplication, QSystemTrayIcon


from biblenotify import Loader, Notifications


if __name__ == "__main__":
    # NOTE: This *has* to be QGuiApplication otherwise the system tray right-click menu won't show
    app = QGuiApplication(sys.argv)
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
    engine.load(":/ui/main.qml")

    sys.exit(app.exec())
