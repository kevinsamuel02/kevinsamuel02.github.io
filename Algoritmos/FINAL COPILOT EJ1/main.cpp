/*Desarrolle una función que retorne una lista (puede ser ordenada o no, a su elección)
a partir de la intersección de una pila y un vector. Defina usted las precondiciones y
estructuras de los nodos de la manera que considere más conveniente y detallada.*/


#include <iostream>

using namespace std;

struct Nodo
{
    int dato;
    Nodo *sgte;
};

int vec[Tam]; //asumo que ya se declaro el tamano

Nodo *interPilaVec (Nodo*pila,int vec[])
{
    Nodo *lista;
    Nodo *auxPila = pila;
    int dato;

    for (int i=0;i<30;i++)
    {
        auxPila=pila;
        while(auxPila!=NULL)
        {
            if (auxPila->dato == vec[i])
            {
                insertarLista(lista,vec[i]);
            }
            auxPila= auxPila->sgte
        }
    }
    return lista;
}


int main()
{

    return 0;
}
