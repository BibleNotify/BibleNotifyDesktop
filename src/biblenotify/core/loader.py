import json
from PySide6.QtCore import QFile, QObject, QTextStream, Slot


class Loader(QObject):
    @Slot()
    def printHello(self):
        print("Hello")

    @Slot(result=str)
    def loadVerses(self) -> str:
        file = QFile("qrc:/verses/bible_verses.json")
        if file.open(QFile.ReadOnly | QFile.Truncate):
            contents = QTextStream(file)
            # print(contents.string())
        return contents
