#! /bin/bash

#### Variables globales
s_null="/dev/null"
defecto='\033[0m'      
rojo='\033[0;31m'          
verde='\033[0;32m'
verde2='\033[1;32m'        
amarillo='\033[0;33m'     
morado='\033[1;35m'       
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
sudo apt-get install mysql-server mysql-client -y &> $s_null 
}

function instalar-phpmyadmin() {
  sudo apt-get install phpmyadmin -y 
  sudo apt-get install apache2 libapache2-mod-php5 php5 mysql-server php-pear php5-mysql mysql-client mysql-server php5-mysql php5-gd -y &> $s_null 
  clear
}

function instalar-prestashop(){
  sudo apt install php-intl -y &> $s_null 
  sudo cp ficheros/php.ini /etc/php/7.4/cli/php.ini &> $s_null 
  sudo wget https://download.prestashop.com/download/releases/prestashop_1.7.7.5.zip &> $s_null 
  sudo unzip prestashop_1.7.7.5.zip -d /var/www/prestashop &> $s_null 
  sudo chown -R www-data: /var/www/prestashop/ &> $s_null 
  sudo a2enmod rewrite &> $s_null 
  sudo cp ficheros/prestashop.conf /etc/apache2/sites-available/prestashop.conf &> $s_null 
  sudo a2ensite prestashop.conf &> $s_null 
  sudo systemctl restart apache2 &> $s_null 
}

function instalar-wordpress(){
  wget https://es.wordpress.org/latest-es_ES.tar.gz &> $s_null 
  sudo tar xf latest-es_ES.tar.gz -C /var/www/html/ &> $s_null 
  sudo chown -R www-data:www-data /var/www/html/wordpress/ &> $s_null 
  sudo cp ficheros/wordpress.conf /etc/apache2/sites-available/wordpress.conf &> $s_null 
  sudo a2ensite wordpress.conf &> $s_null 
  sudo systemctl restart apache2 &> $s_null 
}

function instalar-odoo() {
sudo apt update &> $s_null 
sudo apt install -y git python3-pip build-essential wget python3-dev python3-venv python3-wheel libfreetype6-dev &> $s_null 
sudo apt install -y libxml2-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev &> $s_null 
sudo apt install -y libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev &> $s_null 
sudo useradd -m -d /opt/odoo14 -U -r -s /bin/bash odoo14 &> $s_null 
sudo apt install -y postgresql &> $s_null 
sudo su - postgres -c "createuser -s odoo14" &> $s_null 
sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb &> $s_null 
sudo apt install -y./wkhtmltox_0.12.5-1.bionic_amd64.deb &> $s_null 
su - "odoo14" <<SHT
  git clone https://www.github.com/odoo/odoo --depth 1 --branch 14.0 /opt/odoo14/odoo
  cd /opt/odoo14
  python3 -m venv odoo-venv 
  source odoo-venv/bin/activate
  pip3 install wheel
  pip3 install -r odoo/requirements.txt 
  deactivate
  mkdir /opt/odoo14/odoo-custom-addons
SHT
clear
sudo cp ficheros/odoo14.conf /etc/odoo14.conf &> $s_null 
sudo cp ficheros/odoo14.service /etc/systemd/system/odoo14.service &> $s_null 
sudo systemctl daemon-reload &> $s_null 
sudo systemctl enable --now odoo14 &> $s_null 
sudo service odoo14 restart &> $s_null 
}


function instalar-moodle(){
  sudo apt install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip &> $s_null
  sudo wget https://download.moodle.org/download.php/direct/stable400/moodle-latest-400.tgz &> $s_null
  sudo tar xf moodle-latest-400.tgz -C /var/www/html/ &> $s_null
  sudo chown -R www-data: /var/www/html/moodle/ &> $s_null
  sudo mkdir /var/www/moodledata &> $s_null
  sudo chown www-data: /var/www/moodledata/ &> $s_null
}

function instalar-asterisk(){
  sudo apt install wget build-essential subversion 
  sudo apt-get install wget build-essential subversion 
  cd /usr/local/src/ 
  sudo wget https://github.com/cisco/libsrtp/archive/refs/tags/v2.4.2.zip 
  sudo unzip v2.4.2.zip 
  cd /usr/local/src/libsrtp-2.4.2 
  sudo ./configure CFLAGS=-fPIC --prefix=/usr/local/lib 
  sudo make 
  sudo make install  
  cd /usr/src/ 
  sudo wget http://downloads.asterisk.org/pub/telephony/asterisk/old-releases/asterisk-18.3.0.tar.gz 
  sudo tar zxf asterisk-18.3.0.tar.gz 
  cd asterisk-18.3.0 
  sudo contrib/scripts/get_mp3_source.sh
  sudo contrib/scripts/install_prereq install 
  sudo ./configure --with-pjproject --without-ssl --without-srtp
  sudo make 
  sudo make install 
  sudo mkdir /etc/asterisk/keys 
  cd contrib/scripts 
  clear
  echo "Introduce una frase para la creación del certificado:"
  sudo ./ast_tls_cert -C web.es -O “Mi Empresa” -d /etc/asterisk/keys
  clear
  cd ..
  cd ..
  sudo make basic-pbx  
  sudo make config 
  sudo ldconfig 
  sudo adduser --system --group --home /var/lib/asterisk --no-create-home --gecos "Asterisk PBX" asterisk 
  sudo cp ficheros/asterisk /etc/default/asterisk 
  sudo usermod -a -G dialout,audio asterisk 
  sudo chown -R asterisk: /var/{lib,log,run,spool}/asterisk /usr/lib/asterisk /etc/asterisk 
  sudo chmod -R 750 /var/{lib,log,run,spool}/asterisk /usr/lib/asterisk /etc/asterisk 
  sudo systemctl start asterisk 
  sudo systemctl enable asterisk 
  sudo cp -r ficheros/asterisk_click2dial /opt/odoo14/odoo/addons/asterisk_click2dial 
  sudo cp -r ficheros/base_phone /opt/odoo14/odoo/addons/base_phone 
  clear
}

#### FUNCIÓN PRINCIPAL

function instalar-basic(){

  # Variables.
  let total=10
  let actual=1
  current_user=$(whoami)

  echo -e "$cyan"
  echo "================================================================================"
  echo -e "       PACK PREMIUM de Easy Web Services (c) - Proceso de Instalación        "
  echo "--------------------------------------------------------------------------------"
  echo "    Apache - PHP - MySQL - Prestashop - Wordpress - Odoo - Moodle - Asterisk    "
  echo "================================================================================"
  echo -e "$defecto"
  echo "                ¡Gracias por adquirir el Pack Medium de EWS!"
  echo
  echo


  #### TAREAS

  echo "Instalando Pack Medium ..."
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

  # Tarea 7
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando Wordpress..."
  echo
  instalar-wordpress

  # Tarea 8
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando Odoo..."
  echo
  instalar-odoo

  # Tarea 9
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando Moodle..."
  echo
  instalar-moodle

  # Tarea 10
  let "actual += 1"
  echo "-> Tarea: "$actual/$total
  echo "   Instalando Asterisk..."
  echo
  instalar-asterisk

  # Cuando la instalación termina
  echo -e "$defecto"
  clear
  echo -e "$amarillo"
  figlet -c "EWS" 
  figlet -c "Premium Pack"
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
