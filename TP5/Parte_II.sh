#! /bin/bash
respuesta="s"
#"respuesta" se usa en el bucle while [[ "$respuesta" == "s" ]] para que
#el usuario pueda buscar el clima de otra ciudad despues de haberlo hecho una vez

while [[ "$respuesta" == "s" ]]
do
    echo "Ingrese su ciudad: "
    read ciudad
    echo ""

    #este comando se asegura que ciudades con nombres de mas de una palabra sean validas para el url
    #ej.: "Buenos Aires" -> "Buenos%20Aires"
    ciudadUrl=$(echo "$ciudad" | sed 's/ /%20/g')

    #este curl usa el url de WeatherApi con mi API key y con la variable ciudad ingresada. obtiene los datos
    #y los pasa al archivo "ciudad.json" 
    curl -s "https://api.weatherapi.com/v1/current.json?key=de2e26716fe1485fbd6191652242106&q=${ciudadUrl}&aqi=no" | jq '.' > ciudad.json

    #estas variables obtienen los datos del clima del archivo ciudad.json
    ciudad=$(jq -r '.location.name' ciudad.json)
    pais=$(jq -r '.location.country' ciudad.json)
    horaLocal=$(jq -r '.location.localtime' ciudad.json)
    temp=$(jq -r '.current.temp_c' ciudad.json)
    viento=$(jq -r '.current.wind_kph' ciudad.json)
    humedad=$(jq -r '.current.humidity' ciudad.json)

    #este if busca si el .json contiene un error.
    #si no lo contiene, se imprimen los datos sacados del .json
    if jq -e .error < ciudad.json > /dev/null
    then
        echo "Error, ciudad invalida"
    else
        echo "Clima en ${ciudad}, ${pais}:"
        echo "Hora local: ${horaLocal}"
        echo "Temperatura: ${temp} °C"
        echo "Viento: ${viento} km/h"
        echo "Humedad: ${humedad}%"
    fi

    #se le pregunta al user si quiere buscar otra ciudad
    echo ""
    echo "Desea buscar otra ciudad? [s/n]"
    read respuesta
    echo ""
    until [[ "$respuesta" == "s" || "$respuesta" == "n" ]]
    do
        #se muestra un msj de error si se ingresa un valor invalido
        echo "Error. Respuesta invalida"
        echo "Desea buscar otra ciudad? [s/n]"
        read respuesta
        echo ""
    done
done  

if [[ "$respuesta" == "n" ]]
then
    echo "Gracias por usar el programa. :)"
fi