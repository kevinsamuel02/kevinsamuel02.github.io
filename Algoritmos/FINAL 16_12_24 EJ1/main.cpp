#include <iostream>

using namespace std;

struct Nodo
{
    int dato;
    Nodo *sgte;
};

struct NodoCola
{
    int info;
    NodoCola *fin;
    NodoCola *frente;
};

int vec [vecTam]; //asumo que ya se declaro el tamano.

Nodo *PilaColaYVector (Nodo * pila, NodoCola * cola, int vec [])
{
    Nodo *lista;
    int dato;

    while (pila!= NULL)
    {
        dato = pop (pila);
        insertarOrdenado (lista,dato);
    }

    while (cola!=NULL)
    {
        dato = desencolar(cola->frente);
        insertarOrdenado (lista,cola->frente);
    }

    for (int i=0;i<30;i++)
    {
        insertarOrdenado (lista,vec[i]);
    }

    return lista;
}

int main()
{



    return 0;
}
