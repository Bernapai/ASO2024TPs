TP3
1A)a) Sobre el tiempo que tarda en correr:
En el primer código, el tiempo que tarda en ejecutarse puede variar más debido a que varias partes del programa corren al mismo tiempo. Esto hace que sea menos predecible, ya que el sistema operativo puede decidir cómo dividir el tiempo de procesamiento entre las diferentes
partes del programa.
En el segundo código, las partes del programa se ejecutan una después de otra, lo que hace que sea más predecible cuánto tiempo tomará en total.
1B)Si comparas el tiempo que toma ejecutar los dos códigos, es probable que el primer código, que utiliza subprocesos, termine más rápido que el segundo código, que ejecuta las tareas secuencialmente. Sin embargo, el tiempo exacto puede variar dependiendo de varios factores,
como el sistema en el que se ejecuta el código y cómo está gestionando el sistema operativo los recursos de la computadora.
1C)Durante la primera serie de ejecuciones, sin el retraso adicional en las operaciones del acumulador, las acciones de suma y resta probablemente se superpusieron, lo que hizo que las ejecuciones fueran más rápidas y menos predecibles en términos de tiempo.
En la segunda serie de ejecuciones, al introducir un tiempo de espera adicional en cada iteración del bucle, las acciones de suma y resta se ralentizaron significativamente. 
Esto condujo a una marcada prolongación del tiempo total de ejecución en comparación con las ejecuciones anteriores sin el retraso.
En resumen, al introducir deliberadamente un retraso en el código, se prolongó significativamente el tiempo de ejecución de cada serie de operaciones,
lo que indica que incluso pequeñas modificaciones en el código pueden tener un impacto considerable en el rendimiento del programa.




2a)// Declaración e inicialización de la variable de turno
int turno = 0;

// Bucle para asegurar la equidad en la distribución de hamburguesas
while (turno != (int)tid) {
}

// Sección crítica: aquí se distribuyen las hamburguesas


// Actualización del turno para el siguiente hilo
turno = (turno + 1) % NUMBER_OF_THREADS;






