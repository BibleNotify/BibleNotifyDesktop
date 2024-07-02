import json
import random
import re

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
        global verse
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

        text = self.highlightVerses(contents_json)

        return {
            "text": text,
            "place": contents_json["read"][0]["chapter"]
        }

    @Slot(str, result="QVariant")
    def highlightVerses(self, contents_json):
        # assuming every second verse is preceded by a special delimeter ;
        # another delimeter should be used since this delimeter have too many edge cases
        list = re.split(r";", verse["verse"])
        start = list[0]
        end =  list[-1]

        # to find index of displayed verse from global dictionary {verse} in {contents_json}
        slice1 = re.search(start, contents_json["read"][0]["text"]).span()
        slice2 = re.search(end, contents_json["read"][0]["text"]).span()

        to_bold = contents_json["read"][0]["text"][slice1[0] : slice2[1]]

        # in case of two verses
        if re.search("</p><p><sup>\d</sup>",to_bold):
            number = re.findall(r"\d",to_bold)

            split_pattern = r'</p><p><sup>\d</sup>'
            separator = '</b></p><p><sup>{}</sup><b>'
            split_result = re.split(split_pattern, to_bold)

            # joining inorder to get <b> tag inside of <p> tag and substituting number of second verse
            formatted_string = separator.join(split_result).format(*number)

        # in case of one verses
        else:
            formatted_string = to_bold


        text = contents_json["read"][0]["text"].replace(to_bold, "<b>" + formatted_string + "</b>")

        return text 