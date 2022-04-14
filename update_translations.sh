# TODO: Document where the translations are stored
# TODO: Add command line options to update the TS files or compile the translations
pyside6-lupdate src/biblenotify/biblenotify.qrc -ts translations/biblenotify_en.ts
pyside6-lrelease translations/biblenotify_en.ts -qm src/translations/biblenotify_en.qm

