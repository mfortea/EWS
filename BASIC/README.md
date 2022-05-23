# Pack BASIC - Easy Web Services

Este script ha sido testado correctamente en Ubuntu 20.04 y Ubuntu 18.04.

Este script instala lo siguiente:
- **Servidor Web Apache**
- **PHP 7.2**
- Interfaz web de mySQL **PHPMyAdmin**
- **Base de Datos mySQL**
- **Tienda virtual Prestashop**
- Gestor de contenidos **Wordpress**

## Instalar
Para ejecutar el script, deberá disponer de permisos de superusuario y ejecutar la orden:

``sudo chmod +x BASIC-instalar.sh``

`` sudo ./BASIC-instalar.sh ``

El script instalará todo lo necesario automática, solo se le requerirá interacción al usuario durante la instalación de PHPmyAdmin, para establecer las credenciales que deseemos.

## Una vez instalado el script
- **Apache** sirve por defecto en http://localhost:80
- **Prestashop** tiene su tienda disponible desde http://localhost/tienda
- **Wordpress** se encuentra disponible desde http://localhost/wordpress
- **PHPMyAdmin** se encuentra en la ruta http://localhost/phpmyadmin
- **MySQL** utiliza sus puertos por defecto.

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
