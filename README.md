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




2a)
```c
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h> // para usar intptr_t

#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20

int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
pthread_mutex_t lock; // Mutex para controlar el acceso a la variable compartida
int turno = 0; // Variable para el turno de acceso

void *comer_hamburguesa(void *tid)
{
    int id = (intptr_t) tid;
    while (1)
    {
        // Esperar al turno
        while (turno != id)
        {
            // Pequeña pausa para evitar consumir recursos innecesarios
            sched_yield();
        }

        pthread_mutex_lock(&lock); // Bloquear la sección crítica
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! soy el hilo (comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", id, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // me como una hamburguesa
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
            pthread_mutex_unlock(&lock); // Desbloquear antes de salir de la función
            pthread_exit(NULL); // forzar terminacion del hilo
        }
        turno = (turno + 1) % NUMBER_OF_THREADS; // Cambiar el turno
        pthread_mutex_unlock(&lock); // Desbloquear la sección crítica
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, ret;
    pthread_mutex_init(&lock, NULL); // Inicializar el mutex
    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)(intptr_t)i);
        if (status != 0)
        {
            printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
            exit(-1);
        }
    }

    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        ret = pthread_join(threads[i], NULL); // espero por la terminacion de los hilos que cree
        if (ret != 0)
        {
            printf("Error al esperar la terminación del hilo %d, código de error %d \n", i, ret);
        }
    }

    pthread_mutex_destroy(&lock); // Destruir el mutex
    printf("Todos los hilos han terminado. Adios!\n");
    return 0; // Finalizar el programa
}


2b)

    







