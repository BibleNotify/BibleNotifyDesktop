from PySide6.QtCore import QObject, Slot


class Notifications(QObject):
    @Slot()
    def printHello(self):
        print("Hello")
