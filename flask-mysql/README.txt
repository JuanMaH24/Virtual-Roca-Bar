Virtual Roca Bar - JUAN MANUEL HERRERA QUINTERO 2023-2

Este proyecto no se puede utilizar con fines comerciales. 
No se permite la modificación de la obra ni la creación de obras derivadas sin el permiso expreso del autor. 
Ya que este proyecto será la base de futuras mejoras para intereses del autor.


Definición del proyecto:

Microproyecto para el manejo básico de ventas e inventario de un pequeño bar familiar.
Fue construido con el gestor de manejo de bases de datos MySql y el microframework Flask para Python.

Se eligió el microframework Flask para Python para el desarrollo de este proyecto debido a las facilidades que brinda para manejar
las conexiones con bases de datos y manejo de servidores, se barajó la posibilidad de trabajar con otro Framework muy 
conocido como lo es Django para Python pero este resultaba ser muy robusto para un Microproyecto como el que en esta entrega
se realizó. Se generó la necesidad de entender el funcionamiento de Flask y adaptarlo a las necesidades del Microproyecto descrito
en la semántica entregada a inicios del segundo semestre del año 2023. Además de Flask se hizo uso de otras herramientas o librerias para 
Python que colaboran en la ejecución del servidor para Virtual Roca Bar, en el archivo "requirements.txt" se encuentran todas las librerias 
y herramientas que deben ser instaladas para el perfecto funcionamiento de Virtual Roca Bar. Para más información sobre librerias en Python 
y como instalarlas ingrese en este enlace web https://programminghistorian.org/es/lecciones/instalar-modulos-python-pip

Para la definicion y manejo de la base de datos, se utilizó el SGBD MySql con ayuda de la herramienta PhpMyAdmin otorgada por los servicios 
de WampServer64 o Wamp. En esta herramienta se elaboró la base de datos y luego desde la aplicación creada con Flask se generaron las operaciones
básicas para interactuar con la base de datos alojada en el servidor de Wamp.

En el archivo app.py alojado en la carpeta "src" de este fichero se encuentran todas las operaciones básicas para la aplicación, es decir este 
archivo es el modulo CRUD de la aplicación. Se llama app.py porque Flask trabaja mejor con un archivo raiz llamado app.py, en este archivo es 
donde se activan los servicios de la aplicación. 

Puesta en marcha de la aplicación:

En esta sección se mostrará paso a paso como ejecutar la aplicación para su correcto funcionamiento.
Primero se debe tener instalado lo básico, siendo esto Python y WampServer64. También se deben instalar todas las librerias que estan descritas en 
el archivo "requirements.txt".
Posteriormente se debe descargar el export de la base de datos que se encuentra en este fichero con nombre "roca-bar.sql" y proceder a importarlo en 
PhpMyAdmin con los servicios de WampServer64 activos. Después debe dirigirse al archivo "database.py" alojado en la carpeta "src" de este fichero 
y cambiar las credenciales que en este archivo se definen, estas credenciales (usuario y contraseña) deben ser las mismas con las que usted ingresa
a PhpMyAdmin. 

Una vez se cumplas los pasos antes descritos usted debe ejecutar el archivo "app.py" alojado en la carpeta "src" de este fichero, 
esto se puede hacer ya sea desde un IDE para Python como "Visual Studio Code", otro de su preferencia o desde la propia terminal del equipo.
Si se siguieron correctamente los pasos explicados, usted tendrá los servicios de la aplicación activos en la siguiente URL "http://127.0.0.1:5000".

Si tiene problemas para poner en funcionamiento la aplicación o cualquier otra inquietud, envielas al siguiente correo: j.herrera5@utp.edu.co