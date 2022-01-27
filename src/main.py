import sys
import assets.assets

from PySide6.QtGui import QGuiApplication, QIcon
from PySide6.QtQml import QQmlEngine, QQmlApplicationEngine
from PySide6.QtWidgets import QApplication, QSystemTrayIcon


from biblenotify import Loader, Notifications


if __name__ == "__main__":
    app = QApplication(sys.argv)
    app.setWindowIcon(QIcon(":/icon.svg"))

    engine = QQmlApplicationEngine()
    engine.addImportPath("biblenotify/ui")

    # TODO: Surely there is a better name for this class
    # TODO: Why doesn't this work when the notifications class does?
    loader = Loader()
    engine.rootContext().setContextProperty("Loader", loader)

    notifications = Notifications()
    # TODO: Should this be something other than a context property?
    engine.rootContext().setContextProperty("Notifications", notifications)

    engine.quit.connect(app.quit)
    engine.load("biblenotify/ui/main.qml")

    sys.exit(app.exec())
