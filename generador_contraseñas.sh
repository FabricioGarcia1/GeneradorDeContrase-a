#!/bin/bash

archivo="contraseñas.txt"

while true; do
    echo "====Generador de Contraseñas===="
    echo "1. Generar una contraseña"
    echo "2. Salir"
    read -p "Elije una opción: " opcion

    case $opcion in
        1)
        #Pedir al usuario la longitud de su contraseña
            read -p "Introduce una longitud de contraseña (8-32):" longitud
            if [[ ! $longitud =~ ^[0-9]+$ ]] || [[ $longitud -lt 8 ]] || [[ $longitud -gt 32 ]]; then
                echo "Error, introduce un número válido (8-32)"
                continue
            fi

            read -rp "¿Incluir mayúsculas? (s/n): " mayusculas
            read -rp "¿Incluir números? (s/n): " numeros
            read -rp "¿Incluir caracteres especiales? (s/n): " especiales

            if [[ $mayusculas != "s" && $numeros != "s" && $especiales != "s" ]]; then
                echo "Error, debes elegir al menos una opción"
                continue
            fi

            #Generar los caracteres que va a tener mi motor de contraseñas

            minusculas="abcdefghijklmnñopqrstwxyz"

            if [[ $mayusculas == "s" ]]; then
                caracteres+="ABCDEFGHIJKLMNÑOPQRSTWXYZ"
            fi
            
            if [[ $numeros == "s" ]]; then
                caracteres+="0123456789"
            fi

            if [[ $mayusculas == "s" ]]; then
                caracteres+="!#$&/())=?"
            fi

            #Generar el motor de contraseñas

            password=""

            for (( i=0; i<$longitud; i++ )); do

                rand=$(( RANDOM % ${#caracteres} ))
                password+="${caracteres:$rand:1}"

            done

            echo "Tu contraseña generada es: $password"

            echo "$password" >> $archivo

        ;;
        2)
            echo "Saliendo del sistema..."
            exit 0
        ;;
        *)
            echo "Opción no válida, introduce un número del 1 al 2"
        ;;
    esac
done
