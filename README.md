1. a)
Run Times:

conhilos: 4.19 seg, 4.15 seg, 4.14 seg, 4.19 seg, 4.33 seg.

sinhilos: 6.24 seg, 6.51 seg, 6.07 seg, 6.63 seg, 6.72 seg.

se puede notar que los tiempos de ejecución de conhilos.py
son mas cortos que los tiempos de ejecución de sinhilos.py, 
y podría decirse que son predecibles, ya que sin volverlo a 
ejecutar puedo saber que conhilos.py va a tardar entre 4 y 5
segundos y sinhilos.py va a tardar entre 6 y 7.

b) comparando los tiempos de ejecución mios y de mi 
compañera encontramos que los de conhilos.py tardan entre 
4 y 5 segundos en ambos casos pero los de sinhilos.py en mi 
caso tardan entre 6 y 7 segundos y en el caso de ella tardan 
entre 7 y 8 segundos, asi que concluimos que no son iguales.


c) suma_resta.py (comentado): 

resultado : 0,        runtime: 0.21 s

resultado : 0,        runtime: 0.11 s

resultado : 0,        runtime: 0.46 s

resultado : 0,        runtime: 0.33 s

resultado : 0,        runtime: 0.42 s

resultado : 0,        runtime: 0.24 s

resultado : 0,        runtime: 0.18 s

resultado : 0,        runtime: 0.29 s

resultado : 0,        runtime: 0.24 s

resultado : 0,        runtime: 0.30 s


suma_resta.py (descomentado): 

resultado: -38800,        runtime: 20.80 s

resultado: 113275,        runtime: 23.17 s

resultado: 500000,        runtime: 17.28 s

resultado: -277710,       runtime: 18.67 s

resultado: -348820,       runtime: 17.80 s

resultado: 341000,        runtime: 16.59 s

resultado: 66780,         runtime: 16.21 s

resultado: 473305,        runtime: 16.51 s

resultado: 500000,        runtime: 16.66 s

resultado: -143205,       runtime: 15.98 s

con suma_resta.py comentado se puede observar que el valor 
final siempre es 0 y que tarda menos de 1 segundo en 
ejecutarse. con suma_resta.py descomentado se puede observar 
que tarda (en mi caso) entre 15 y 24 segundos y que el 
resultado varia demasiado. esto se debe a que al descomentar 
agregamos un bucle que se ejecuta 1000 veces en cada hilo, 
lo que hace que el programa tarde muchísimo mas. A su vez, 
esto genera una condición de carrera, es decir,que ambos 
hilos modifican la variable acumulador simultanemante y sin 
sincronizarse, lo que hace que el valor final sea 
impredecible.

3. a)
```c
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20
int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0;

void *comer_hamburguesa(void *tid)
{
	while (1 == 1)
	{ 
		while (turno != (long)tid);
    // INICIO DE LA ZONA CRÍTICA
		if (cantidad_restante_hamburguesas > 0)
		{
			printf("Hola! soy el hilo(comensal) %d , me voy a comer una hamburguesa ! ya que todavia queda/n %d \n", (int) tid, cantidad_restante_hamburguesas);
			cantidad_restante_hamburguesas--; // me como una hamburguesa
		}
		else
		{
			printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
			turno = (turno + 1) % NUMBER_OF_THREADS;
			pthread_exit(NULL); // forzar terminacion del hilo
		}
    // SALIDA DE LA ZONA CRÍTICA   
		turno = (turno + 1) % NUMBER_OF_THREADS;
	}
}

int main(int argc, char *argv[])
{
	pthread_t threads[NUMBER_OF_THREADS];
	int status;
	for (long i = 0; i < NUMBER_OF_THREADS; i++)
	{
		printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
		status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
		if (status != 0)
		{
			printf("Algo salio mal, al crear el hilo recibi el codigo de error %d \n", status);
			exit(-1);
		}
	}

	for (long i = 0; i < NUMBER_OF_THREADS; i++)
	{
		void *retval;
		pthread_join(threads[i], &retval); // espero por la terminacion de los hilos que cree
	}
	pthread_exit(NULL); // como los hilos que cree ya terminaron de ejecutarse, termino yo tambien.
}
```
![TP3 Arq](https://github.com/ClasiCKGit/ASO2024TPs/assets/167462930/aa89f9a6-daf4-406b-9f48-42b9db525b33)
