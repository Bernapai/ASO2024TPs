TP3
1A)a) Sobre el tiempo que tarda en correr:
En el primer código, el tiempo que tarda en ejecutarse puede variar más debido a que varias partes del programa corren al mismo tiempo. Esto hace que sea menos predecible, ya que el sistema  puede decidir cómo dividir el tiempo de procesamiento entre las diferentes
partes del programa.
En el segundo código, las partes del programa se ejecutan una después de otra, lo que hace que sea más predecible cuánto tiempo tomará en total.

1B)Si comparas el tiempo que toma ejecutar los dos códigos, es probable que el primer código, que utiliza subprocesos y termine más rápido que el segundo código, que ejecuta las tareas secuencialmente. Sin embargo, el tiempo exacto puede variar dependiendo de varios factores,como el sistema en el que se ejecuta el código y cómo está gestionando el sistema operativo los recursos de la computadora.

1C (corregido) :Durante la primera serie de ejecuciones, sin el retraso adicional en las operaciones del acumulador, las acciones de suma y resta probablemente se superpusieron. Esto hizo que las ejecuciones fueran más rápidas pero también menos predecibles en términos de tiempo. La razón de esta falta de predictibilidad es que las operaciones concurrentes pueden provocar race conditions, donde varios hilos intentan acceder y modificar el mismo recurso al mismo tiempo sin control adecuado. Estas race conditions pueden llevar a resultados inesperados y tiempos de ejecución variables, ya que los hilos compiten por recursos compartidos en zonas críticas sin la debida sincronización.

Cuando introdujimos un tiempo de espera adicional en cada iteración del bucle en la segunda serie de ejecuciones, las acciones de suma y resta se ralentizaron considerablemente. Este retraso permitió que cada operación se completara sin solapamientos, disminuyendo las race conditions y haciendo que el tiempo de ejecución fuera más predecible, aunque mucho más largo. En resumen, al meter a propósito un retraso en el código, no solo se prolongó bastante el tiempo de ejecución, sino que también se hizo más evidente la importancia de gestionar correctamente las zonas críticas. Esto muestra cómo incluso pequeños cambios en el código pueden tener un impacto significativo en el rendimiento del programa.










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


2b)![Captura de pantalla TP3](TP3/Captura%20de%20pantalla%202024-05-14%20184542.png)


    







