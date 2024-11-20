# Importaciones
from flask import render_template, request, redirect, url_for, session, flash
from werkzeug.security import check_password_hash, generate_password_hash
from email.mime.text import MIMEText
import smtplib
import random
from app import app, mysql
from flask import jsonify  
#CONECTAR BASE DE DATOS CON LA APP UCSS
@app.route('/api/login', methods=['POST'])
def api_login():
    data = request.json  # Obtener datos enviados en formato JSON
    correo = data.get('correo')  # Asegúrate de usar las claves correctas del JSON
    contraseña = data.get('contrasena')

    cursor = mysql.connection.cursor()

    try:
        # Consulta a la base de datos para obtener el usuario
        cursor.execute('SELECT id, nombre, apellido, correo, contraseña FROM usuarios WHERE correo = %s', (correo,))
        usuario = cursor.fetchone()

        # Verificar si el usuario existe y si la contraseña es válida
        if usuario and check_password_hash(usuario[4], contraseña):  # Contraseña está en la posición 4
            return jsonify({
                "success": True,
                "message": "Login exitoso",
                "data": {
                    "id": usuario[0],
                    "nombre": usuario[1],
                    "apellido": usuario[2],
                    "correo": usuario[3]
                }
            })
        else:
            return jsonify({"success": False, "message": "Correo o contraseña incorrectos"})

    except Exception as e:
        return jsonify({"success": False, "message": f"Error del servidor: {str(e)}"})

    finally:
        cursor.close()

def generar_correo_institucional(nombre, apellido_paterno, apellido_materno):
    # Eliminar espacios y generar correo
    nombre = nombre.strip()
    apellido_paterno = apellido_paterno.strip()
    apellido_materno = apellido_materno.strip() if apellido_materno else ''

    # Generamos el correo institucional
    if apellido_materno:
        correo = f"{nombre.lower()}.{apellido_paterno.lower()}.{apellido_materno[0].lower()}@ucss.edu.pe"
    else:
        correo = f"{nombre.lower()}.{apellido_paterno.lower()}@ucss.edu.pe"
    
    return correo


def generar_contrasena_aleatoria():
    # Crear contraseña aleatoria
    caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()"
    return ''.join(random.choice(caracteres) for i in range(10))

from email.mime.text import MIMEText
import smtplib

def enviar_correo_bienvenida(correo_destino, correo_institucional, contrasena, carrera):
    try:
        # Crear mensaje MIME
        mensaje = MIMEText(
            f"Felicitaciones por ingresar a {carrera}. UCSS te da la bienvenida!\n\n"
            f"Para entrar al SGA utiliza estos datos:\n"
            f"Correo institucional: {correo_institucional}\n"
            f"Contraseña: {contrasena}\n\n"
            f"¡Bienvenido a la UCSS!",
            'plain',  # Tipo de contenido
            'utf-8'   # Codificación explícita en UTF-8
        )
        
        mensaje['Subject'] = 'Bienvenido a UCSS'
        mensaje['From'] = 'no-reply@ucss.edu.pe'
        mensaje['To'] = correo_destino

        # Configurar servidor de correo
        servidor = smtplib.SMTP('smtp.gmail.com', 587)
        servidor.starttls()
        servidor.login('desarrollobasado@gmail.com', 'aqow qxfc pqzg xgav') 
        servidor.sendmail('no-reply@ucss.edu.pe', correo_destino, mensaje.as_string())  
        servidor.quit()

        print("Correo enviado exitosamente.")
    except smtplib.SMTPAuthenticationError:
        print("Error de autenticación. Verifica tu correo y contraseña de aplicación.")
    except smtplib.SMTPException as e:
        print("Error al enviar el correo SMTP:", e)
    except Exception as e:
        print("Error general al enviar el correo:", e)

# Rutas de la aplicación
@app.route('/')
def index():
    return render_template('index.html')

# Ruta para la postulación
@app.route('/postula-aqui', methods=['GET', 'POST'])
def postula_aqui():
    if request.method == 'POST':
        # Procesar datos del formulario
        nombre = request.form['nombre']
        apellido_paterno = request.form['apellido_paterno']
        apellido_materno = request.form['apellido_materno']
        email = request.form['email']
        numero_celular = request.form['numero_celular']
        numero_documento = request.form['numero_documento']
        carrera = request.form['carrera']
        
        cursor = mysql.connection.cursor()
        try:
            cursor.execute('INSERT INTO postulantes (nombre, apellido_paterno, apellido_materno, email, numero_celular, numero_documento, carrera) VALUES (%s, %s, %s, %s, %s, %s, %s)',
                           (nombre, apellido_paterno, apellido_materno, email, numero_celular, numero_documento, carrera))
            mysql.connection.commit()
            flash('Tu solicitud ha sido enviada correctamente.')
            return redirect(url_for('index'))
        except Exception as e:
            mysql.connection.rollback()
            flash('Error al enviar la solicitud. Inténtalo de nuevo.')
            print(e)
        finally:
            cursor.close()
    
    return render_template('postula_aqui.html')

# Rutas para administración de postulantes
@app.route('/admin/postulantes')
def admin_postulantes():
    if 'loggedin' in session and session['rol'] == 'administrador':
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM postulantes')
        postulantes = cursor.fetchall()
        cursor.close()
        return render_template('admin_postulantes.html', postulantes=postulantes)
    flash('No tienes acceso a esta página.')
    return redirect(url_for('login'))  # Redirige a la página de login si no es admin

@app.route('/admin/aceptar_postulante/<int:id>', methods=['POST'])
def aceptar_postulante(id):
    cursor = mysql.connection.cursor()
    try:
        # Obtener datos del postulante y crear usuario
        cursor.execute("SELECT nombre, apellido_paterno, apellido_materno, email, numero_documento, numero_celular, carrera FROM postulantes WHERE id = %s", (id,))
        postulante = cursor.fetchone()

        if postulante:
            nombre, apellido_paterno, apellido_materno, email, numero_documento, numero_celular, carrera = postulante

            # Generar correo institucional y contraseña aleatoria
            correo_institucional = generar_correo_institucional(nombre, apellido_paterno, apellido_materno)
            contrasena = generar_contrasena_aleatoria()
            contrasena_hash = generate_password_hash(contrasena)

            # Imprimir el correo y la contraseña en la consola
            print(f'Correo Institucional: {correo_institucional}')
            print(f'Contraseña: {contrasena}')  # Muestra la contraseña en texto plano

            # Actualizar estado en postulantes
            cursor.execute("UPDATE postulantes SET estado = 'aceptado' WHERE id = %s", (id,))

            # Insertar en la tabla de usuarios
            cursor.execute("INSERT INTO usuarios (nombre, apellido, correo, contraseña, rol) VALUES (%s, %s, %s, %s, %s)",
                           (nombre, apellido_paterno, correo_institucional, contrasena_hash, 'alumno'))
            usuario_id = cursor.lastrowid  # Obtener el ID del usuario recién creado

            # Insertar en la tabla de alumnos con el usuario_id y datos del postulante
            cursor.execute("INSERT INTO alumno (usuario_id, nombre, apellido_paterno, apellido_materno, numero_documento, numero_celular, carrera) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                           (usuario_id, nombre, apellido_paterno, apellido_materno, numero_documento, numero_celular, carrera))

            mysql.connection.commit()
            
            # Enviar correo de bienvenida
            enviar_correo_bienvenida(email, correo_institucional, contrasena, carrera)  # Se usa la carrera del postulante
            flash('Postulante aceptado, usuario y alumno creados exitosamente.')
        else:
            flash('Postulante no encontrado.')
    except Exception as e:
        mysql.connection.rollback()
        flash('Error al aceptar postulante y crear usuario/alumno.')
        print(e)
    finally:
        cursor.close()
    return redirect(url_for('admin_postulantes'))




@app.route('/admin/rechazar_postulante/<int:id>', methods=['POST'])
def rechazar_postulante(id):
    cursor = mysql.connection.cursor()
    try:
        cursor.execute("UPDATE postulantes SET estado = 'rechazado' WHERE id = %s", (id,))
        mysql.connection.commit()
        flash('Postulante rechazado exitosamente.')
    except Exception as e:
        flash('Error al rechazar postulante.')
        print(e)
    finally:
        cursor.close()
    return redirect(url_for('admin_postulantes'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        correo = request.form['correo']  
        contrasena = request.form['contrasena']  
        
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM usuarios WHERE correo = %s', (correo,))
        usuario = cursor.fetchone()  # Obtener el usuario de la base de datos
        
        if usuario and check_password_hash(usuario[4], contrasena):  # Verifica el hash de la contraseña
            session['loggedin'] = True
            session['rol'] = usuario[5]  # Asigna el rol del usuario
            flash('Has iniciado sesión exitosamente.')
            return redirect(url_for('admin_postulantes'))  # Redirige al panel de administración
        else:
            flash('Credenciales incorrectas. Inténtalo de nuevo.')
    
    return render_template('login.html')

# Ruta para el login de estudiantes
@app.route('/login_estudiante', methods=['GET', 'POST'])
def login_estudiante():
    if request.method == 'POST':
        correo = request.form['correo']
        contraseña = request.form['contrasena']
        
        cursor = mysql.connection.cursor()
        
        # Consulta para obtener el usuario que coincida con el correo
        cursor.execute('SELECT id, nombre, apellido, correo, contraseña FROM usuarios WHERE correo = %s', (correo,))
        usuario = cursor.fetchone()
        
        # Verificamos si el usuario existe y si la contraseña es correcta
        if usuario and check_password_hash(usuario[4], contraseña):  # Indexamos el campo contraseña correctamente
            # Guardar el id del usuario y otros datos relevantes en la sesión
            session['loggedin'] = True
            session['id'] = usuario[0]       # Asignar el id del usuario
            session['nombre'] = usuario[1]   # Asignar el nombre del usuario
            session['correo'] = usuario[3]   # Asignar el correo del usuario
            
            return redirect(url_for('sga'))  # Redirigir al SGA si el login es exitoso
        else:
            flash('Correo o contraseña incorrectos. Inténtalo de nuevo.')
    
    return render_template('login_estudiante.html')


@app.route('/resultados-admision')
def resultados_admision():
    cursor = mysql.connection.cursor()
    # Asegurarse que el estado, carrera y demás campos existan en tu tabla de postulantes
    cursor.execute('SELECT numero_documento, nombre, apellido_paterno, carrera, estado FROM postulantes')
    resultados = cursor.fetchall()
    cursor.close()
    
    return render_template('resultados_admision.html', resultados=resultados)

# Rutas para las carreras
@app.route('/medicina')
def medicina():
    return render_template('medicina.html')

@app.route('/administracion-negocios')
def administracion_negocios():
    return render_template('administracion_negocios.html')

@app.route('/ciencia-computacion')
def ciencia_computacion():
    return render_template('ciencia_computacion.html')

@app.route('/ingenieria-electronica')
def ingenieria_electronica():
    return render_template('ingenieria_electronica.html')

@app.route('/educacion')
def educacion():
    return render_template('educacion.html')

@app.route('/psicologia')
def psicologia():
    return render_template('psicologia.html')

@app.route('/ingenieria-ambiental')
def ingenieria_ambiental():
    return render_template('ingenieria_ambiental.html')

# Rutas para "Vive San Stelman"
@app.route('/quienes-somos')
def quienes_somos():
    return render_template('quienes_somos.html')

@app.route('/autoridades')
def autoridades():
    return render_template('autoridades.html')

@app.route('/profesores')
def profesores():
    return render_template('profesores.html')

@app.route('/preguntas-frecuentes')
def preguntas_frecuentes():
    return render_template('preguntas_frecuentes.html')

# Rutas para "Posgrado"
@app.route('/programas')
def programas():
    return render_template('programas.html')

@app.route('/maestrias')
def maestrias():
    return render_template('maestrias.html')

@app.route('/diplomados')
def diplomados():
    return render_template('diplomados.html')

@app.route('/cursos-programas-especializados')
def cursos_programas_especializados():
    return render_template('cursos_programas_especializados.html')

# Ruta para el SGA (Sistema de Gestión Academico)
@app.route('/sga')
def sga():
    if 'loggedin' in session:
        user_id = session['id']
        cursor = mysql.connection.cursor()
        
        # Cambia `carrera_id` a `carrera` si esa es la columna correcta
        cursor.execute(''' 
            SELECT alumno.nombre, alumno.apellido_paterno, alumno.apellido_materno, 
                   alumno.numero_documento, alumno.numero_celular, 
                   alumno.carrera, usuarios.correo
            FROM alumno
            LEFT JOIN usuarios ON alumno.usuario_id = usuarios.id
            WHERE usuarios.id = %s
        ''', (user_id,))
        
        user_data = cursor.fetchone()
        
        if user_data:
            nombre_alumno = user_data[0]
            carrera = user_data[5]  # Cambiado a carrera
            print(f"Nombre: {nombre_alumno}, Carrera: {carrera}")  # Verificar datos
            
            # Ahora buscar los cursos usando el nombre de la carrera
            cursor.execute('''
                SELECT c.nombre 
                FROM cursos c 
                JOIN carreras ca ON c.carrera_id = ca.id 
                WHERE c.semestre = 1 AND ca.nombre = %s
            ''', (carrera,))
            cursos = cursor.fetchall()
            print(f"Cursos: {cursos}")  # Verificar cursos
            
            return render_template('sga.html', user=user_data, cursos=cursos)
        else:
            flash('Usuario no encontrado. Por favor, inicie sesión nuevamente.')
            return redirect(url_for('login_estudiante'))
    else:
        flash('Debes iniciar sesión para acceder a esta página.')
        return redirect(url_for('login_estudiante'))

@app.route('/terminos')
def terminos():
    return render_template('terminos.html')

@app.route('/politica-datos')
def politica_datos():
    return render_template('politica_datos.html')

@app.route('/actualizar_informacion', methods=['POST'])
def actualizar_informacion():
    if 'loggedin' in session:
        user_id = session['id']
        numero_celular = request.form['numero_celular']  # Solo este campo será actualizado
        
        # Aquí iría la lógica para manejar la subida de fotos (si decides implementarlo)

        cursor = mysql.connection.cursor()
        try:
            # Actualiza solo el número de celular
            cursor.execute(''' 
                UPDATE alumno 
                SET numero_celular = %s 
                WHERE usuario_id = %s
            ''', (numero_celular, user_id))
            
            mysql.connection.commit()
            flash('Información actualizada exitosamente.')
        except Exception as e:
            mysql.connection.rollback()
            flash('Error al actualizar la información.')
            print(e)
        finally:
            cursor.close()

        return redirect(url_for('sga'))
    else:
        flash('Debes iniciar sesión para acceder a esta página.')
        return redirect(url_for('login_estudiante'))
