# Pack Medium - Easy Web Services

<img src="../assets/MEDIUM.png" width="180"/>

Este script ha sido testado correctamente en Ubuntu 18.04. Queda pendiente probar su compatibilidad con Ubuntu 20.04

Este script instala lo siguiente:
- **Servidor Web Apache**
- **PHP 7.2**
- Interfaz web de mySQL **PHPMyAdmin**
- **Base de Datos mySQL**
- **Tienda virtual Prestashop**
- Gestor de contenidos **Wordpress**
- El CRM **Odoo**
- El aula virtual **Moodle**

## Instalar
Para ejecutar el script, deberá disponer de permisos de superusuario y ejecutar la orden:

``sudo chmod +x MEDIUM-instalar.sh``

`` sudo ./MEDIUM-instalar.sh ``

El script instalará todo lo necesario automática, solo se le requerirá interacción al usuario durante la instalación de PHPmyAdmin, para establecer las credenciales que deseemos.

## Una vez instalado el script
- **Apache** sirve por defecto en http://localhost:80
- **Prestashop** tiene su tienda disponible desde http://localhost/tienda
- **Wordpress** se encuentra disponible desde http://localhost/wordpress
- **PHPMyAdmin** se encuentra en la ruta http://localhost/phpmyadmin
- **MySQL** utiliza sus puertos por defecto
- **Odoo** es accesible a través de http://localhost:8069
- **Moodle** es accesible desde http://localhost/moodle

### mySQL
Si deseamos crear un usuario para mySQL para cada servicio, debemos seguir los pasos siguientes desde la consola de mySQL:

```console 
sudo mysql -u root -p
```
```sql
> create database MI_BASE_DE_DATOS charset utf8mb4 collate utf8mb4_unicode_ci;
> create user MI_USUARIO@localhost identified by 'XXXXXXXX';
> create user MI_USUARIO@localhost identified with mysql_native_password by 'XXXXXXXX';
> grant all privileges on MI_BASE_DE_DATOS.* to MI_USUARIO@localhost;
> exit
```

Una vez hecho esto, ya solo es necesario indicar la base de datos y las credenciales que deseemos para cada servicio instalado (Prestashop, Wordpress...)

### Odoo
Para poder iniciar Odoo una vez instalado, es necesario cambiar manualmente la contraseña establecida en ``` /etc/odoo14.conf```, esta contraseña usada para la base de datos "odoo" será también "odoo" por defecto.

## Licencia
El contenido de este repositorio está sujeto bajo una licencia [Boost Software License 1.0](../LICENSE)

