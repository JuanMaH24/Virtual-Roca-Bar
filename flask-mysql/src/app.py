import os

from flask import Flask, render_template, request, redirect, url_for, flash
from flask_login import LoginManager, login_user, logout_user, login_required, current_user

import database as db
from model.User import User

template_dir = os.path.dirname(os.path.abspath(os.path.dirname(__file__)))
template_dir = os.path.join(template_dir, 'src', 'templates')


app = Flask(__name__, template_folder = template_dir)
app.secret_key =  'B!1w8NAt1T^%kvhUI*S^'

login_manager_app = LoginManager(app)

@login_manager_app.user_loader
def load_user(user_id):
    try:
        cursor = db.database.cursor()
        sql = "SELECT user_id, user_name, name, lastname, rol FROM usuarios WHERE user_id = {}".format(user_id)
        cursor.execute(sql)
        row = cursor.fetchone()
        if row != None:
            return User(row[0], row[1], None, row[2], row[3], row[4])
        else:
            return None
    except Exception as ex:
            raise Exception(ex)

@app.route("/")
def index():
    if current_user.is_active:
        return redirect(url_for('home'))
    else:
        return redirect(url_for('login'))

def login_method(user):
    try:
        cursor = db.database.cursor()
        sql = """SELECT user_id, user_name, password, name, lastname, rol FROM usuarios 
                WHERE user_name = '{}'""".format(user.user_name)
        cursor.execute(sql)
        row = cursor.fetchone()
        cursor.close()
        if row != None:
            user = User(row[0], row[1], User.check_password(row[2], user.password), row[3], row[4], row[5])
            return user
        else:
            return None
    except Exception as ex:
        raise Exception(ex)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        user = User(0, request.form['username'], request.form['password'])  
        logged_user = login_method(user)
        if logged_user != None:
            if logged_user.password:
                login_user(logged_user)
                return redirect(url_for('home'))
            else:
                flash("Contraseña Incorrecta...")
                return render_template('login.html')
        else:
            flash("Usuario no registrado...")
            return render_template('login.html')
    else:
        return render_template('login.html')

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('login'))


@app.route('/home')
@login_required
def home():
    cursor = db.database.cursor()
    cursor.execute("SELECT product_id, product_name, product_price, product_cant FROM productos WHERE estado_borrado = 1")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    # return render_template('index.html', data=insertObject)
    return render_template('home.html', data=insertObject)


@app.route('/addProduct')
@login_required
def routeaddProduct():
    return render_template('addProduct.html')

@app.route('/addProduct1', methods=['POST'])
@login_required
def addProduct():
    if request.method == 'POST':
        name = request.form['product_name']
        price = request.form['product_price']
        cant = request.form['product_cant']

        if (name and price and cant) and (int(price) >= 0) and (int(cant) >= 0):
            cursor = db.database.cursor()
            sql = f"INSERT INTO productos (product_name, product_price, product_cant) VALUES ('{str(name)}', {int(price)}, {int(cant)})"
            cursor.execute(sql)
            db.database.commit()
        else:
            print("INGRESE CORRECTAMENTE LOS VALORES")
        return redirect(url_for('routeaddProduct'))
    else:
        return redirect(url_for('home'))

@app.route('/searchProduct', methods=['POST'])
@login_required
def routesearchProduct():
    name = request.form['product_name']
    cursor = db.database.cursor()
    cursor.execute(f"SELECT product_id, product_name, product_price, product_cant FROM productos WHERE product_name LIKE '%{name}%' AND estado_borrado = 1")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    # return render_template('index.html', data=insertObject)
    return render_template('searchProduct.html', data=insertObject)

@app.route('/updateProduct/<string:id>', methods=['POST'])
@login_required
def updateProduct(id):
    if request.method == 'POST':
        name = request.form['product_name']
        price = request.form['product_price']

        if (name and price) and (int(price) >= 0):
            cursor = db.database.cursor()
            sql = f"UPDATE productos SET product_name = '{str(name)}' ,product_price = {int(price)} WHERE product_id = {id} AND estado_borrado = 1"
            cursor.execute(sql)
            db.database.commit()
        else:
            print("INGRESE CORRECTAMENTE LOS VALORES")
        return redirect(url_for('home'))
    else:
        return redirect(url_for('home'))
    
@app.route('/deleteProduct/<string:id>', methods=['POST'])
@login_required
def deleteProduct(id):
    cursor = db.database.cursor()
    sql = f"UPDATE productos SET estado_borrado = 0 WHERE product_id = {id}"
    cursor.execute(sql)
    db.database.commit()    
    return redirect(url_for('home'))

@app.route('/suppliers')
@login_required
def routeSuppliers():
    cursor = db.database.cursor()
    cursor.execute("SELECT supplier_id, supplier_name, supplier_contact, supplier_tipe FROM proveedores WHERE estado_borrado = 1")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    return render_template('supplier_template.html', data=insertObject)

@app.route('/addSupplier', methods=['POST'])
@login_required
def addSupplier():
    if request.method == 'POST':
        name = request.form['supplier_name']
        contact = request.form['supplier_contact']
        tipe = request.form['supplier_tipe']
        if (name and contact and tipe):
            cursor = db.database.cursor()
            sql = f"INSERT INTO proveedores (supplier_name, supplier_contact, supplier_tipe) VALUES ('{str(name)}', '{str(contact)}', '{str(tipe)}')"
            cursor.execute(sql)
            db.database.commit()
        else:
            print("INGRESE CORRECTAMENTE LOS VALORES")
        return redirect(url_for('routeSuppliers'))
    else:
        return redirect(url_for('routeSuppliers'))


@app.route('/updateSupplier/<string:id>', methods=['POST'])
@login_required
def updateSupplier(id):
    if request.method == 'POST':
        name = request.form['supplier_name']
        contact = request.form['supplier_contact']
        tipe = request.form['supplier_tipe']

        if (name and contact and tipe):
            cursor = db.database.cursor()
            sql = f"UPDATE proveedores SET supplier_name = '{str(name)}' ,supplier_contact = '{str(contact)}', supplier_tipe = '{str(tipe)}' WHERE supplier_id = {id} AND estado_borrado = 1"
            cursor.execute(sql)
            db.database.commit()
        else:
            print("INGRESE CORRECTAMENTE LOS VALORES")
        return redirect(url_for('routeSuppliers'))
    else:
        return redirect(url_for('routeSuppliers'))  


@app.route('/deleteSupplier/<string:id>', methods=['POST'])
@login_required
def deleteSupplier(id):
    cursor = db.database.cursor()
    sql = f"UPDATE proveedores SET estado_borrado = 0 WHERE supplier_id = {id}"
    cursor.execute(sql)
    db.database.commit()    
    return redirect(url_for('routeSuppliers'))

@app.route('/addShopcar/<string:id>', methods=['POST'])
@login_required
def addShopcar(id):
    cursor = db.database.cursor()
    try:
        sql = f"INSERT INTO carrito (user_id, product_id) VALUES ({current_user.user_id}, {id})"
        cursor.execute(sql)
    except:
        None
    db.database.commit()    
    return redirect(url_for('home'))

@app.route('/shopCar')
@login_required
def routeshopCar():
    cursor = db.database.cursor()
    cursor.execute("SELECT carrito.shopcar_id, carrito.user_id, carrito.product_id, carrito.product_cant,productos.product_name, productos.product_price, productos.product_cant AS inventory, (carrito.product_cant * productos.product_price) as totalshop FROM carrito INNER JOIN productos ON carrito.product_id=productos.product_id WHERE estado_borrado = 1")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    totalshopcar = 0
    try:
        for d in insertObject:
            totalshopcar += d['totalshop']
    except:
        None
    return render_template('shopCar.html', data = insertObject, total = totalshopcar)

@app.route('/updshopCar/<string:id>', methods=['POST'])
@login_required
def updateshopCar(id):
    if request.method == 'POST':
        cant = request.form['product_cant']
        if (cant) and (int(cant)>=0):
            cursor = db.database.cursor()
            sql = f"UPDATE carrito SET product_cant = '{int(cant)}' WHERE user_id = {current_user.user_id} AND product_id = {id}"
            cursor.execute(sql)
            db.database.commit()
        else:
            print("INGRESE CORRECTAMENTE LOS VALORES")
        return redirect(url_for('routeshopCar'))
    else:
        return redirect(url_for('routeshopCar'))
    
@app.route('/deleteshopCar/<string:id>')
@login_required
def deleteshopCar(id):
    cursor = db.database.cursor()
    sql = f"DELETE FROM carrito WHERE shopcar_id = {id}"
    cursor.execute(sql)
    db.database.commit()    
    return redirect(url_for('routeshopCar'))

@app.route('/makeShop', methods=['POST'])
@login_required
def makeShop():
    if request.method == 'POST':
        cursor = db.database.cursor()
        sql = f"INSERT INTO ventas (user_id, product_id, product_cant) SELECT carrito.user_id, carrito.product_id, carrito.product_cant FROM carrito WHERE 1"
        cursor.execute(sql)
        sql = f"UPDATE productos SET product_cant = product_cant - (SELECT SUM(product_cant) FROM carrito WHERE productos.product_id = carrito.product_id) WHERE EXISTS (SELECT 1 FROM carrito WHERE productos.product_id = carrito.product_id);"
        cursor.execute(sql)
        sql = f"DELETE FROM carrito"
        cursor.execute(sql)
        db.database.commit() 
        return redirect(url_for('home'))
    else:
        return redirect(url_for('home'))


@app.route('/sales')
@login_required
def routeSales():
    cursor = db.database.cursor()
    cursor.execute("SELECT ventas.sale_id, usuarios.name, usuarios.lastname, productos.product_name, ventas.product_cant, ventas.sale_date FROM ventas, usuarios, productos WHERE ventas.user_id = usuarios.user_id AND ventas.product_id = productos.product_id AND ventas.estado_borrado = 1")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    return render_template('sales_template.html', data=insertObject)


@app.route('/searchUserSale', methods=['POST'])
@login_required
def searchUserSale():
    name = request.form['user_name']
    cursor = db.database.cursor()
    cursor.execute(f"SELECT ventas.sale_id, usuarios.name, usuarios.lastname, productos.product_name, ventas.product_cant, ventas.sale_date FROM ventas, usuarios, productos WHERE ventas.user_id = usuarios.user_id AND ventas.product_id = productos.product_id AND usuarios.name LIKE '%{name}%' AND ventas.estado_borrado = 1")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    return render_template('sales_template.html', data=insertObject)

@app.route('/userSales/<string:id>')
@login_required
def routeUserSales(id):
    cursor = db.database.cursor()
    cursor.execute(f"SELECT ventas.sale_id, usuarios.name, usuarios.lastname, productos.product_name, ventas.product_cant, ventas.sale_date FROM ventas, usuarios, productos WHERE ventas.user_id = usuarios.user_id AND ventas.product_id = productos.product_id AND usuarios.user_id = {int(id)} AND ventas.estado_borrado = 1")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    return render_template('sales_template.html', data=insertObject)


if __name__ == '__main__':
    app.run(debug=True,port=5000)