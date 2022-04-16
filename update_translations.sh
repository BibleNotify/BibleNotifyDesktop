# TODO: Document where the translations are stored
# TODO: Add command line options to update the TS files or compile the translations

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -r|--regen) MODE="regen"; shift;;
        -c|--compile) MODE="compile"; shift;;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift

if [[ $MODE = "regen" ]]; then
    pyside6-lupdate src/biblenotify/biblenotify.qrc -ts translations/biblenotify_en.ts
elif [[ $MODE = "compile" ]]; then
    pyside6-lrelease translations/biblenotify_en.ts -qm src/translations/biblenotify_en.qm
fi
