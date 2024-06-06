TP3
1A)a) Sobre el tiempo que tarda en correr:
En el primer código, el tiempo que tarda en ejecutarse puede variar más debido a que varias partes del programa corren al mismo tiempo. Esto hace que sea menos predecible, ya que el sistema  puede decidir cómo dividir el tiempo de procesamiento entre las diferentes
partes del programa.
En el segundo código, las partes del programa se ejecutan una después de otra, lo que hace que sea más predecible cuánto tiempo tomará en total.

1B)Si comparas el tiempo que toma ejecutar los dos códigos, es probable que el primer código, que utiliza subprocesos y termine más rápido que el segundo código, que ejecuta las tareas secuencialmente. Sin embargo, el tiempo exacto puede variar dependiendo de varios factores,como el sistema en el que se ejecuta el código y cómo está gestionando el sistema operativo los recursos de la computadora.

1C (corregido) :Durante la primera serie de ejecuciones, sin el retraso adicional en las operaciones del acumulador, las acciones de suma y resta probablemente se superpusieron. Esto hizo que las ejecuciones fueran más rápidas pero también menos predecibles . La razón de esta falta de prediccion es que las operaciones simultaneas pueden provocar race conditions, donde varios hilos intentan acceder y modificar el mismo recurso al mismo tiempo sin control adecuado. Estas race conditions pueden llevar a resultados inesperados y tiempos de ejecución variables, ya que los hilos pelean por recursos compartidos en zonas críticas sin la debida sincronización.

Cuando introdujimos un tiempo de espera adicional en cada iteración del bucle en la segunda serie de ejecuciones, las acciones de suma y resta se ralentizaron demasiado. Este retraso permitio que cada operación se completara sin superposiciones, disminuyendo las race conditions y haciendo que el tiempo de ejecución fuera más predecible, aunque mucho más largo. En resumen, al meter a propósito un retraso en el código, no solo se alargo bastante el tiempo de ejecución, sino que también se hizo más evidente la importancia de manejar correctamente las zonas críticas. Esto demuestra cómo incluso  cambios chicos en el código pueden tener un impacto significativo en el rendimiento del programa.










2a)(CORREGIDO)
```c
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20

int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0; // coloque el código aquí

void *comer_hamburguesa(void *tid)
{
    while (1)
    {
        while (turno != (int)tid) // coloque el código aquí
            ;

        // INICIO DE LA ZONA CRÍTICA
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! Soy el hilo (comensal) %d, me voy a comer una hamburguesa! Todavía quedan %d \n", (int)tid, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // Me como una hamburguesa
        }
        else
        {
            printf("NO HAY MAS HAMBURGUESAS :( \n");
            turno = (turno + 1) % NUMBER_OF_THREADS;
            pthread_exit(NULL); // Forzar terminación del hilo
        }
        turno = (turno + 1) % NUMBER_OF_THREADS; // coloque el código aquí
        // SALIDA DE LA ZONA CRÍTICA
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, i, ret;

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
        if (status != 0)
        {
            printf("Algo salió mal, al crear el hilo recibí el código de error %d \n", status);
            exit(-1);
        }
    }

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        void *retval;
        ret = pthread_join(threads[i], &retval); // Esperar por la terminación de los hilos que creé
    }

    pthread_exit(NULL); // Terminar el programa
}


2b)
<img width="866" alt="image" src="https://github.com/Bernapai/ASO2024TPs/assets/132232663/cee9d232-c19b-45cc-b8bc-88bae2a36963">



    







