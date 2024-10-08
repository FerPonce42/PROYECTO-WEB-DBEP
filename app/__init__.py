import sys
import locale

# Asegurar que la salida y entorno de la aplicación utilicen UTF-8
sys.stdout.reconfigure(encoding='utf-8')
locale.setlocale(locale.LC_ALL, 'es_ES.UTF-8')

from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config.from_object('config.Config')  # Asegura que las configuraciones se carguen desde tu archivo de configuración

mysql = MySQL(app)

from app import routes  # Importa tus rutas aquí para registrar las rutas de la aplicación
