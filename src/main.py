import sys
import assets.assets

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlEngine, QQmlApplicationEngine


from biblenotify import Loader, Notifications


# try:
#     # For Windows
#     from PyQt5.QtWinExtras import QtWin
#     pretzel_id = 'iwoithe.molar.app.0.0.1'
#     QtWin.setCurrentProcessExplicitAppUserModelID(pretzel_id)
# except ImportError:
#     pass


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

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
