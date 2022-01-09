import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlEngine, QQmlApplicationEngine


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

    # parse = Parse()
    # engine.rootContext().setContextProperty("Parse", parse)

    engine.quit.connect(app.quit)
    engine.load("biblenotify/ui/main.qml")

    sys.exit(app.exec())
