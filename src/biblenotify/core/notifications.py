import json

from PySide6.QtCore import QDateTime, QFile, QObject, QTextStream, QTime, Slot


class Notifications(QObject):
    notificationsEnabled = False
    notificationTime = QDateTime()

    @Slot(result=bool)
    def getNotificationsEnabled(self) -> bool:
        return self.notificationsEnabled

    @Slot(bool)
    def setNotificationsEnabled(self, value):
        self.notificationsEnabled = value

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

        if (currentTime.hour() == notificationTime.hour()) and (currentTime.minute() == notificationTime.minute()):
            return True

        return False

    # The methods here on are temporarily in this class until the Loader() class problem is fixed

    @Slot(result=str)
    def loadVerses(self) -> str:
        file = QFile(":/verses/bible_verses.json")
        if not file.open(QFile.ReadOnly | QFile.Text):
            return ""

        contents = QTextStream(file)
        verses_string = contents.readAll()

        verses = json.loads(verses_string)
        print(verses["all"])

        return verses_string
