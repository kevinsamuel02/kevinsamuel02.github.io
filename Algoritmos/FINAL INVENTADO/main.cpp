#include <iostream>

using namespace std;

struct Nodo
{
    int dato;
    Nodo *sgte;
};

struct NodoCola
{
    Nodo *fin;
    Nodo *frente;
};

int vec[Tam]; //supongo que ya esta declarado

Nodo *interseccionPilaColaVec (Nodo *pila, NodoCola *cola, int vec[])
{
    Nodo *listaInter;
    int dato;
    Nodo *auxCola=cola->frente;
    Nodo *auxPila=pila;

    for (int i=0;i<30;i++)
    {
        auxPila=pila;
        while (auxPila!=NULL)
        {
            if (auxPila->dato == vec[i])
            {
                auxCola=cola->frente
                    while (auxCola!=NULL)
                {
                        if (auxCola->dato==vec[i])
                    {
                        insertarLista (listaInter,vec[i]);
                    }
                }
                auxCola = auxCola->sgte;

            }
            auxPila = auxPila->sgte
        }
    }
    return listaInter;
}
int main()
{



    return 0;
}
