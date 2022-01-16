import sys
import assets.assets

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlEngine, QQmlApplicationEngine


from biblenotify import Notifications


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

    # TODO: Should this be something other than a context property?
    notifications = Notifications()
    engine.rootContext().setContextProperty("Notifications", notifications)

    engine.quit.connect(app.quit)
    engine.load("biblenotify/ui/main.qml")

    sys.exit(app.exec())
