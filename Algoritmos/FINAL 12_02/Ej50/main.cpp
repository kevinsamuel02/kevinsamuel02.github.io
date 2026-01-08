/*Crear una lista que almacene "n" números enteros  y calcular el menor y mayor de ellos.*/


#include <iostream>
#include <stdlib.h>
#include <conio.h>
using namespace std;

struct NodoListaSE
{
    int info;
    NodoListaSE *sgte=NULL;
};

void insertarLista(NodoListaSE*& inicio, int n) {
    NodoListaSE* nuevo = new NodoListaSE();
    nuevo->info = n;
    nuevo->sgte = NULL;

    if (inicio == NULL || n < inicio->info) {
        nuevo->sgte = inicio;
        inicio = nuevo;
    } else {
        NodoListaSE* aux = inicio;

        while (aux->sgte != NULL && aux->sgte->info < n) {
            aux = aux->sgte;
        }

        nuevo->sgte = aux->sgte;
        aux->sgte = nuevo;
    }
}


int main()
{
    NodoListaSE *inicio= NULL;
    NodoListaSE *nuevo = NULL;
    NodoListaSE *aux = NULL;
    int t,dato;
    cout << "Cuantos valores desea ingresar? ";
    cin >> t;
    for (int i =0;i<t;i++)
    {
        cout << "Ingrese un numero: ";
        cin >> dato;
        insertarLista (inicio,dato);
    }

    cout << "El menor elemento fue: " << inicio->info << endl;
   aux = inicio;
   while (aux ->sgte != NULL)
   {
       aux = aux ->sgte;
   }
   cout << "El mayor elemento fue: " << aux ->info << endl;

    return 0;
}
