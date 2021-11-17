#!/bin/bash

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c()
{
	echo -e " \n\n${redColour}[!] Saliendo....${endColour}"
	exit 1
}

function helpPanel()
{
	echo -e "\n${blueColour}[*]${endColour}${grayColour} Uso de la herramienta whichSystem.sh ${endColour}\n"
	echo -e "\n${yellowColour}[!] Ejemplo: ./whichSystem.sh -H 127.0.0.1${endColour}\n"
	echo -e "\n${purpleColour}\t-H: host de la maquina a escanerar\n${endColour}"
	echo -e "\n${purpleColour}\t-h: ayuda\n${endColour}"
	exit 0
}

function analize()
{
	ttl_value=$(ping -c 2 $host | grep "=" | head -n 1 | awk '{print $6}' | cut -d '=' -f 2)

	echo -e "\t${yellowColour}[*]${endColour} ${grayColour}El SO del host: $host es:${endColour}\n"
	if [[ ttl_value -gt 60 ]] && [[ ttl_value -le 64 ]]; then
		echo -e "\t\t${greenColour}Linux${endColour}"
	fi

	if [[ ttl_value -gt 120 ]] && [[ ttl_value -le 128 ]]; then
		echo -e "\t\t${greenColour}Windows${endColour}"
	fi
}

# Main function
declare -i parameter_counter=0; while getopts ":h:H:" arg; do
	case $arg in
		H) host=$OPTARG; let parameter_counter+=1 ;;
		h) help=$OPTARG
	esac
done

if [ $parameter_counter -ne 1 ]; then
	helpPanel
else
	analize
fi
