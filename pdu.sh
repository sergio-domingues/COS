#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Sin argumentos. Mira <pdu -h> para ayuda con este script"
    exit 1
fi

validate_lamp () {
  if [ $1 -lt 1 ] || [ $1 -gt 8 ]
    then
     return 0 #faillure
  else
     return 1 #success
fi
}

MAX_LAMP=9
MIN_LAMP=0

ACCION=-1

while getopts "10ahn:f:l:" opt; do
  case $opt in
    h) 
      echo "Usage: pdu <acción> <salidas>\nDonde <acción> indica la operación a realizar:\n\t-1: Encender\n\t-0: Apagar\n<salidas>:\n\t-a: Todas las salidas\n\t-n x: La salida x\n\t-f x: Desde la salida x\n\t–l y: Hasta la salida y\n <x [1-8]>"      
      exit 1;
      ;;
    0)
      ACCION=0
      echo "apagar"
      ;;
    1)
      ACCION=1
      echo "encender"
     ;;
     
    a)
      if [ $ACCION -eq 0 ]
	then
	  echo "Apagar todas"  
	  sh apaga_todas.sh
	  exit 1
      elif [ $ACCION -eq 1 ]
	then
	  echo "Enciende todas"
	  sh enciende_todas.sh
	  exit 1
      else
	  echo "Error: no sido cogida una <accion> valida. Mira <pdu -h> para ayuda con este script"
	  exit 1
      fi
      ;;   
      
    n)
      lamp=$OPTARG
      
      validate_lamp $lamp
      ret=$?
      
      if [ $ret -eq 0 ]
	then
	  echo "Error: no sido cogida una <bombilla> valida. Mira <pdu -h> para ayuda con este script"
	  exit 1
      fi
      
      #handle action 
      if [ $ACCION -eq 0 ]
	then
	  echo "Apagar"  
	  sh apaga.sh "$lamp"
	  exit 1
      elif [ $ACCION -eq 1 ]
	then
	  echo "Enciende"
	  sh enciende.sh "$lamp"
	  exit 1
      else
	  echo "Error: no sido cogida una <accion> valida. Mira <pdu -h> para ayuda con este script"
	  exit 1
      fi      
      ;;
      
    f) #desde la salida x
      lamp=$OPTARG
      
      validate_lamp $lamp
      ret=$?
      
      if [ $ret -eq 0 ]
	then
	  echo "Error: no sido cogida una <bombilla> valida. Mira <pdu -h> para ayuda con este script"
	  exit 1
      fi
            
       #handle action 
      if [ $ACCION -eq 0 ]
	then
	  echo "Apagar"  
	  
	  i=$(($lamp))
	  while [ $i -lt $MAX_LAMP ] 	    
	    do
	      sh apaga.sh "$i"
	      i=$((i+1))
	      sleep 0.1
	    done	
	    
	  exit 1
	  
      elif [ $ACCION -eq 1 ]
	then
	  echo "Enciende"
	  
	  i=$(($lamp))
	  while [ $i -lt $MAX_LAMP ] 
	  do
	    sh enciende.sh "$i"
	    i=$((i+1))
	    sleep 0.1
	  done	 
	  
	  exit 1
      else
	  echo "Error: no sido cogida una <accion> valida. Mira <pdu -h> para ayuda con este script"
	  exit 1
      fi 
      ;;
      
    l) #hasta la salida x
      lamp=$OPTARG
      
      validate_lamp $lamp
      ret=$?
      
      if [ $ret -eq 0 ]
	then
	  echo "Error: no sido cogida una <bombilla> valida. Mira <pdu -h> para ayuda con este script"
	  exit 1
      fi
            
       #handle action 
      if [ $ACCION -eq 0 ]
	then
	  echo "Apagar"  
	  
	  i=1
	  while [ $lamp -gt 0 ] 	    
	    do
	      sh apaga.sh "$i"
	      i=$((i+1))
	      lamp=$((lamp-1))
	      sleep 0.1
	    done	 
	  exit 1
	  
      elif [ $ACCION -eq 1 ]
	then
	  echo "Enciende"
	  
	  i=1
	  while [ $lamp -gt 0 ] 
	  do
	    sh enciende.sh "$i"
	    i=$((i+1))
	    lamp=$((lamp-1))
	    sleep 0.1
	  done 
	  exit 1
	  
      else
	  echo "Error: no sido cogida una <accion> valida. Mira <pdu -h> para ayuda con este script"
	  exit 1
      fi    
    
      ;;
#    \?)
#      echo "Invalid option: -$OPTARG. Check <pdu -h> for help about this script"
#      exit 1
#     ;;   
    :)
      echo "Option -$OPTARG requires and argument, check <pdu -h> for help about this script"
      exit 1      
    ;;
  esac
done