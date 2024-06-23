
#!/bin/bash

# Solicitar al usuario que ingrese un nombre
echo "Ingrese un nombre para deducir su genero"
read nombre

genero=$(curl -s https://api.genderize.io/?name=$nombre | jq -r ".gender")
if [[ "$genero" == "male" ]]; then
    echo "$nombre: Hombre"
else echo "$nombre: Mujer" 
fi