#! /bin/bash

#### Variables globales
s_null="/dev/null"
defecto='\033[0m'      
rojo='\033[0;31m'          
verde='\033[0;32m'        
amarillo='\033[0;33m'     
morado='\033[0;35m'       
cyan='\033[0;36m'        


#### FUNCIONES DE INSTALACIONES
function instalar-dependencias(){
  sudo apt install figlet unzip -y &> $s_null 
}

function update-y-upgrade() {
  apt-get update -y &> $s_null 
}

function instalar-apache() {
sudo apt-get install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y &> $s_null 
sudo apt-get install libapache2-mod-php5 php5 php5-common php5-curl php5-dev php5-gd php5-idn php-pear php5-imagick php5-mcrypt php5-mysql php5-ps php5-pspell php5-recode php5-xsl -y &> $s_null 
sudo chown -R www-data:www-data /var/ww &> $s_null 
sudo a2enmod rewrite &> $s_null 
sudo php5enmod mcrypt &> $s_null 
sudo service apache2 restart &> $s_null 
}

function instalar-mysql() {
sudo apt-get install mysql-server mysql-client libmysqlclient15.dev -y &> $s_null 
}

function instalar-phpmyadmin() {
sudo apt-get install phpmyadmin -y &> $s_null 
sudo apt-get install apache2 libapache2-mod-php5 php5 mysql-server php-pear php5-mysql mysql-client mysql-server php5-mysql php5-gd -y &> $s_null 

}

function instalar-prestashop(){
sudo wget https://download.prestashop.com/download/releases/prestashop_1.7.7.5.zip
sudo unzip prestashop_1.7.7.5.zip -d /var/www/prestashop
sudo chown -R www-data: /var/www/prestashop/
sudo a2enmod rewrite
sudo cp ficheros/prestashop.conf /etc/apache2/sites-available/prestashop.conf
sudo a2ensite prestashop.conf
sudo systemctl restart apache2
}



#### FUNCIÓN PRINCIPAL

function instalar-basic(){

  # Variables.
  let total=5
  let actual=1
  current_user=$(whoami)

  echo -e "$cyan"
  echo "================================================================================"
  echo -e "         PACK BASIC de Easy Web Services (c) - Proceso de Instalación        "
  echo "--------------------------------------------------------------------------------"
  echo "                  Apache - PHP - MySQL - Prestashop - Wordpress                 "
  echo "================================================================================"
  echo -e "$defecto"
  echo "                ¡Gracias por adquirir el Pack Basic de EWS!"
  echo
  echo


  #### TAREAS

  echo "Instalando Pack Basic ..."
  echo -e "$morado"

  # Tarea 1
  echo "-> Tarea: "$actual/$total
  echo "   Actualizando los repositorios..."
  echo
  update-y-upgrade

  # Tarea 2
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando dependencias..."
  echo
  instalar-dependencias

  # Tarea 3
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando Apache..."
  echo
  instalar-apache

  # Tarea 4
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando mySQL..."
  echo
  instalar-mysql

  # Tarea 5
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando PHPMyAdmin..."
  echo
  instalar-phpmyadmin

  # Tarea 6
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando Prestashop..."
  echo
  instalar-prestashop


  # Cuando la instalación termina
  echo -e "$defecto"
  clear
  echo -e "$cyan"
  figlet -c "EWS" 
  figlet -c "BASIC Pack"
  echo -e "$defecto"
  echo -e "$verde"
  echo "           ***** LA INSTALACIÓN HA FINALIZADO CORRECTAMENTE *****              "
  echo -e "$defecto"
  echo "        [!] Siga las instrucciones del fichero README para continuar           "
  echo


  # Liberamos Variables
  total=
  actual=
  s_null=
  current_user=
}


#### INICIO DEL SCRIPT
clear

# Comprobamos que somos root
if [ "$(id -u)" != "0" ]; then
   echo -e "$rojo"
   echo "============================================================================"
   echo "               [!] DEBE EJECUTAR EL SCRIPT COMO SUPERUSUARIO"
   echo "============================================================================"
   echo -e "$defecto"
    exit 1
else
  instalar-basic
    exit 1
fi