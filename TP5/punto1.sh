

# Generar un número aleatorio entre 1 y 100
numero_aleatorio=$(( RANDOM % 100 + 1 ))

echo "Bienvenido al juego de adivinar el numero"
echo "Se genero un número entre 1 y 100. Intenta adivinarlo"


#solicitar intentos hasta que el usuario adivine el número
while true; do
    # Solicitar un intento al usuario
    read -p "Introduce tu Numero: " numero

    # Comprobar si el intento es un número valido entre los parametros
    if ! [[ "$numero" =~ ^[0-9]+$ ]]; then
        echo "Por favor, introduce un número válido."
        continue
    fi

    # Comparar el numero seleccionado por el aleatorio
    if (( numero < numero_aleatorio )); then
        echo "Demasiado bajo. Intenta nuevamente."
    elif (( numero > numero_aleatorio )); then
        echo "Demasiado alto. Intenta nuevamente."
    else
        echo "¡Felicidades! Adivinaste el numero correcto: $numero_aleatorio"
        break
    fi
done
