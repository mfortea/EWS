#! /bin/bash

function instalar-basic(){
  # Variables.
  let proc=2
  s_null="/dev/null"
  current_user=$(whoami)
  # Texto de introducción.
  echo "================================================================================"
  echo -e "      PACK BASIC de Easy Web Services - Proceso de Instalación"
  echo "================================================================================"
  # Indicamos al usuario que comenzamos las tareas.
  echo
  echo "[Realizando tareas, espere un momento por favor (No cierre la terminal)...]"
  echo
  echo "Procesos restantes: "$proc
  # Tareas.
  #
  sudo apt install figlet -y &> $s_null #
  let "proc -= 1"
  echo "Procesos restantes: "$proc
  #
  apt-get update -y &> $s_null #
  let "proc -= 1"
  echo "Procesos restantes: "$proc
  # Indicamos al usuario que hemos finalizado las tareas.
  figlet -c "EWS" 
  figlet -c "BASIC Pack"
  echo
  echo "[Tareas finalizadas con éxito]"
  echo
  # Liberamos Variables.
  proc=
  s_null=
  current_user=
}
# Limpiamos terminal de comandos ejecutados anteriormente.
clear
# Comprobamos que el fichero Bash ha sido ejecutado como SuperUsuario - root.
if [ "$(id -u)" != "0" ]; then
   echo
   echo "============================================================================"
   echo "DEBE EJECUTAR EL SCRIPT COMO SUPERUSUARIO" 1>&2
   echo "============================================================================"
   echo
    exit 1
else
  instalar-basic
    exit 1
fi