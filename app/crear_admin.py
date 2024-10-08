import sys
import os

# Agregar el directorio padre al sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from werkzeug.security import generate_password_hash
from app import app, mysql

# Crear contexto de aplicación
with app.app_context():
    # Conexión a la base de datos
    cursor = mysql.connection.cursor()

    # Generar un hash de la contraseña
    hashed_password = generate_password_hash('admin123') 

    # Insertar usuario administrador
    cursor.execute('INSERT INTO usuarios (nombre, apellido, correo, contraseña, rol) VALUES (%s, %s, %s, %s, %s)', 
                   ('Admin', 'Usuario', 'admin@example.com', hashed_password, 'administrador'))

    # Guardar cambios y cerrar conexión
    mysql.connection.commit()
    cursor.close()

print("Usuario administrador creado exitosamente.")
