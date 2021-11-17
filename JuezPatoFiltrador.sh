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
        echo -e "\n${blueColour}[*]${endColour}${grayColour} Uso de la herramienta JuezPatoFiltrador.sh ${endColour}\n"
        echo -e "\n${yellowColour}[!] Ejemplo: ./JuezPatoFiltrador.sh -u1 MarcoReus -u2 dj282_301${endColour}\n"
        echo -e "\n${yellowColour}     Donde se mostrara los ejercicios que tiene el usuario u pero no tiene el usuario v${endColour}\n"
        echo -e "\n${purpleColour}\t-u: usuario 1${endColour}"
        echo -e "\n${purpleColour}\t-v: usuario 2${endColour}"
        exit 0
}

function analize()
{
	curl -s -k -d user=$U1 -G "https://jv.umsa.bo/userinfo.php" | grep "p(" | tr ';' '\n' | sed 's/.*(\(.*\))/\1/' | grep -E '(.*[[:digit:]])' > user1.txt
	curl -s -k -d user=$U2 -G "https://jv.umsa.bo/userinfo.php" | grep "p(" | tr ';' '\n' | sed 's/.*(\(.*\))/\1/' | grep -E '(.*[[:digit:]])' > user2.txt

	file1="user1.txt"
	file2="user2.txt"

	diff $file1 $file2 > diferencia.txt

	cat diferencia.txt | grep "<" | sed 's/< //' > salida.txt

        echo "[*] Cantidad de ejercicios diferencia: $(wc -l salida.txt)"



        rm -r user1.txt; rm -r user2.txt; rm -r diferencia.txt
}

declare -i parameter_counter=0; while getopts ":h:u:v:" arg; do
        case $arg in
                u) U1=$OPTARG; let parameter_counter+=1 ;;
		v) U2=$OPTARG; let parameter_counter+=1 ;;
                h) help=$OPTARG
        esac
done

if [ $parameter_counter -ne 2 ]; then
        helpPanel
else
        analize
fi


