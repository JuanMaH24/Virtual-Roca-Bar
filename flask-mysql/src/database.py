import mysql.connector

database = mysql.connector.connect(
    host='localhost', #Cambiar por su host de PhpMyAdmin
    user='root', #Cambiar por su usuario de PhpMyAdmin
    password='', #Cambiar por su contraseña en PhpMyAdmin
    database='roca_bar' #Asegurese que el nombre este correcto
)