import json
import random
import re

from PySide6.QtCore import QDateTime, QFile, QObject, QTextStream, QTime, Slot


class Notifications(QObject):
    notificationsEnabled = False
    notificationSentLock = False
    notificationTime = QDateTime()
    currentVerse = ""

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
        versesString = contents.readAll()

        verses = json.loads(versesString)
        # Choose a random verse
        self.currentVerse = verses["all"][random.randint(0, len(verses["all"]))]

        # TODO: Need to decide on the key names
        return {
            "text": self.currentVerse["verse"],
            "place": self.currentVerse["place"],
            "location": self.currentVerse["data"]
        }

    @Slot(str, result="QVariant")
    def loadChapter(self, location: str) -> dict:
        file = QFile(":/chapters/" + location + ".json")
        if not file.open(QFile.ReadOnly | QFile.Text):
            return ["", ""]

        contents = QTextStream(file)
        contentsString = contents.readAll()

        verse = self.currentVerse["verse"]
        contentsJson = json.loads(contentsString)

        chapter = contentsJson
        chapterPlace = chapter["read"][0]["chapter"]

        highlightedChapter = self.highlightVerse(verse, chapter)

        return {
            "text": highlightedChapter,
            "place": chapterPlace
        }

    def highlightVerse(self, verse: str, chapter: dict) -> str:
        chapterText = chapter["read"][0]["text"]
        
        verseMatch = re.search(re.escape(verse), chapterText)
        match = verseMatch.span()
       
        toHighlight = chapterText[match[0] : match[1]]

        highlightedChapter = chapterText.replace(toHighlight, "<b>" + toHighlight + "</b>")
        
        return highlightedChapter
    