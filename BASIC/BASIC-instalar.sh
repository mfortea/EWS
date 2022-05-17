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
  sudo apt install figlet -y &> $s_null 
}

function update-y-upgrade() {
  apt-get update -y &> $s_null 
}

#### FUNCIÓN PRINCIPAL

function instalar-basic(){

  # Variables.
  let total=2
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

  echo -e "$defecto"

  # Cuando la instalación termina
  clear
  figlet -c "EWS" 
  figlet -c "BASIC Pack"
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