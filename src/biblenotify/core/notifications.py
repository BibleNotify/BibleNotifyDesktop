import json
import random

from PySide6.QtCore import QDateTime, QFile, QObject, QTextStream, QTime, Slot


class Notifications(QObject):
    notificationsEnabled = False
    notificationSentLock = False
    notificationTime = QDateTime()

    @Slot(result=bool)
    def getNotificationsEnabled(self) -> bool:
        return self.notificationsEnabled

    @Slot(bool)
    def setNotificationsEnabled(self, value):
        self.notificationsEnabled = value

    @Slot(result=bool)
    def getNotificationSentLock(self) -> bool:
        return self.notificationSentLock
    
    @Slot(bool)
    def setNotificationSentLock(self, value: bool) -> None:
        self.notificationSentLock = value

    @Slot(result=QDateTime)
    def getNotificationTime(self) -> QDateTime:
        return self.notificationTime

    @Slot(int, int, str)
    def setNotificationTime(self, hour: int, minute: int, ap: str):
        newTime = QTime()

        if hour == 12:
            if ap == "AM":
                newTime.setHMS(0, minute, 0)
            elif ap == "PM":
                newTime.setHMS(12, minute, 0)
        elif ap == "AM":
            newTime.setHMS(hour, minute, 0)
        elif ap == "PM":
            newTime.setHMS(hour + 12, minute, 0)

        self.notificationTime.setTime(newTime)

    @Slot(result=bool)
    def isNotificationTime(self) -> bool:
        currentTime = QDateTime.currentDateTime().time()
        notificationTime = self.notificationTime.time()

        if (currentTime.hour() == notificationTime.hour()) and (currentTime.minute() == notificationTime.minute()) and not self.notificationSentLock:
            self.notificationSentLock = True
            return True
        elif (currentTime.hour() != notificationTime.hour()) or (currentTime.minute() != notificationTime.minute()):
            self.notificationSentLock = False
            return False

        return False

    # The methods here on are temporarily in this class until the Loader() class problem is fixed

    @Slot(result="QVariant")
    def loadVerses(self) -> dict:
        file = QFile(":/verses/bible_verses.json")
        if not file.open(QFile.ReadOnly | QFile.Text):
            return {
                "verse": "",
                "place": "",
                "data": ""
            }

        contents = QTextStream(file)
        verses_string = contents.readAll()

        verses = json.loads(verses_string)
        # Choose a random verse
        verse = verses["all"][random.randint(0, len(verses["all"]))]

        # TODO: Need to decide on the key names
        return {
            "text": verse["verse"],
            "place": verse["place"],
            "location": verse["data"]
        }

    @Slot(str, result="QVariant")
    def loadChapter(self, location: str) -> dict:
        file = QFile(":/chapters/" + location + ".json")
        if not file.open(QFile.ReadOnly | QFile.Text):
            return ["", ""]

        contents = QTextStream(file)
        contents_string = contents.readAll()

        contents_json = json.loads(contents_string)

        return {
            "text": contents_json["read"][0]["text"],
            "place": contents_json["read"][0]["chapter"]
        }
