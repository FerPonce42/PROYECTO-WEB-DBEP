import sys
import locale

# Configurar la salida estándar para que use UTF-8
sys.stdout.reconfigure(encoding='utf-8')
locale.setlocale(locale.LC_ALL, 'es_ES.UTF-8')# Establece la localización a español con UTF-8

from app import app  # Importa la aplicación Flask desde el paquete `app`


# Ejecutar la aplicación Flask en modo depuración
if __name__ == '__main__':
    app.run(debug=True)
