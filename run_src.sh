sh ./update_qrc.sh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    python3 src/main.py
elif [[ "$OSTYPE" == "darwin"* ]]; then
    python3 src/main.py
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
    python src/main.py
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    python src/main.py
else
    echo "[ERROR] 'run_src.sh' does not support this OS"
fi
