import sys
import locale

# Configuración UTF-8
sys.stdout.reconfigure(encoding='utf-8')
locale.setlocale(locale.LC_ALL, 'es_ES.UTF-8')

from flask import Flask
from flask_mysqldb import MySQL

# Inicialización de Flask
app = Flask(__name__)
app.config.from_object('config.Config')  

# Configuración de la Base de Datos MySQL
mysql = MySQL(app)

# Importación de Rutas
from app import routes  
