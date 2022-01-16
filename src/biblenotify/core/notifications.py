from PySide6.QtCore import QDateTime, QObject, QTime, Slot


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
