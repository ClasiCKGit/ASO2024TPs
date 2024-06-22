#! /bin/bash
respuesta="s"
contUser=0
#contUser va a contar las veces que el user gana el piedra, papel o tijera
contPc=0
#contPc va a contar las veces que el user gana el piedra, papel o tijera
while [[ "$respuesta" == "s" ]]
do

    min=1
    max=3
    numRand=$((RANDOM % (max - min + 1) + min))
    elecPc=$numRand
    #se genera un numero random que va a determinar la jugada de la pc y se le 
    #asigna a la variable elecPC
    until [[ $elecUser == 1 || $elecUser == 2 || $elecUser == 3 ]]
    do
        echo "PIEDRA PAPEL O TIJERA EXTREMO!!!!!"
        echo "1 = tijera"
        echo "2 = papel"
        echo "3 = piedra"
        echo ""
        echo "Ingrese su jugada: "
        read elecUser
        #el user ingresa su jugada
        echo ""
        if [[ $elecUser != 1 && $elecUser != 2 && $elecUser != 3 ]]
        #si ingresa un valor invalido, se muestra un msj de error
        then 
            echo "Respuesta invalida, intentelo nuevamente."
            echo "_________________________________________"
            echo ""
        fi
    done 
    #en estos if se comparan las jugadas de la pc y del user y 
    #se determina un ganador o si hay un empate
    if [ $elecPc -eq $elecUser ]
    then
        echo "EMPATE EPICO!!"
    elif [[ $elecPc -eq 1 && $elecUser -eq 2 ]]
    then 
        echo "la pc gana"
        contPc=$((contPc + 1))
    elif [[ $elecPc -eq 2 && $elecUser -eq 3 ]]
    then 
        echo "la pc gana"
        contPc=$((contPc + 1))
    elif [[ $elecPc -eq 3 && $elecUser -eq 1 ]]
    then 
        echo "la pc gana"
        contPc=$((contPc + 1))
    else
        echo "el user gana"
        contUser=$((contUser + 1))
    fi
    #en estos case, los valores "1, 2 y 3" pasan a ser 
    #"tijera, papel y piedra respectivamente para se mostrados en la terminar"
    case $numRand in 
    1) 
    elecPc="tijera"
    ;;
    2)
    elecPc="papel"
    ;;
    3)
    elecPc="piedra"
    ;;
    esac

    case $elecUser in 
    1) 
    elecUser="tijera"
    ;;
    2)
    elecUser="papel"
    ;;
    3)
    elecUser="piedra"
    ;;
    esac

    #se muestran los resultados y se le pregunta al user si quere seguir jugando
    echo "pc: $elecPc, user: $elecUser"
    echo "Puntaje: pc $contPc - user $contUser"
    echo ""
    echo "¿Desea seguir jugando? [s/n]: "
    read respuesta
    echo "____________________________________"
    echo ""
    until [[ "$respuesta" == "s" || "$respuesta" == "n" ]]
    do
        #si se ingresa un valor invalido, se muestra un msj de error
        echo "Respuesta invalida, intentelo nuevamente."
        echo "¿Desea seguir jugando? [s/n]: "
        read respuesta
        echo "____________________________________"
        echo ""
    done
done