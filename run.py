import sys
import locale

# Asegurar que la salida del entorno utilice UTF-8
sys.stdout.reconfigure(encoding='utf-8')
locale.setlocale(locale.LC_ALL, 'es_ES.UTF-8')

from app import app  # Importa tu aplicación Flask desde el paquete `app`

if __name__ == '__main__':
    app.run(debug=True)
