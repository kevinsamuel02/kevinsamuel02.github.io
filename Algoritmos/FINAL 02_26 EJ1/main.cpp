/*Desarrolle una funcion que retorne una lista ordenada a partir de la interseccion de 1 pila y 1 lista.
Defina usted las precondiciones y estructuras de los nodos de manera que considere mas conveniente detallar*/


#include <iostream>

using namespace std;

struct Nodo
{
    int dato;
    Nodo *sgte;
};

void insertarPila (Nodo *&pila, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo-> dato = n;
    nuevoNodo->sgte = pila;
    pila = nuevoNodo;
}

void insertarLista (Nodo *&lista, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo-> dato = n;
    nuevoNodo->sgte = lista;
    lista = nuevoNodo;
}

void insertarListaO(Nodo*& listaO, int n) {
    Nodo* nuevoNodo = new Nodo();
    nuevoNodo->dato = n;
    nuevoNodo->sgte = nullptr;

    if (listaO == nullptr || listaO->dato > n) {
        // Insertar al inicio si la lista está vacía o si el primer elemento es mayor
        nuevoNodo->sgte = listaO;
        listaO = nuevoNodo;
    } else if (listaO->dato == n) {
        // Evitar duplicado si el primer elemento ya es el mismo
        delete nuevoNodo;
    } else {
        Nodo* actual = listaO;
        while (actual->sgte != nullptr && actual->sgte->dato < n) {
            actual = actual->sgte;
        }

        // Evitar duplicado antes de la inserción
        if (actual->sgte != nullptr && actual->sgte->dato == n) {
            delete nuevoNodo;
        } else {
            nuevoNodo->sgte = actual->sgte;
            actual->sgte = nuevoNodo;
        }
    }
}

void mostrarListaO(Nodo* listaO) {
    Nodo* actual = listaO;
    while (actual != NULL) {
        cout << actual->dato << " ";
        actual = actual->sgte;
    }
    cout << endl;
}

void interseccionListaYPila(Nodo*& listaO, Nodo* lista, Nodo* pila) {
    while (lista != NULL)
        {
        Nodo* auxPila = pila;
        while (auxPila != NULL) {
            if (auxPila->dato == lista->dato) {
                insertarListaO(listaO, auxPila->dato);
            }
            auxPila = auxPila->sgte;
        }
        lista = lista->sgte;
    }
}




int main()
{
    Nodo* lista = NULL;
    Nodo *listaO= NULL;
    Nodo* pila =NULL;

    insertarPila(pila, 3);
    insertarPila(pila, 8);
    insertarPila(pila, 1);

    insertarLista (lista,12);
    insertarLista (lista,7);
    insertarLista (lista,6);

    interseccionListaYPila (listaO,lista,pila);


    cout << "Lista ordenada: ";
    mostrarListaO(listaO);

    // Liberar memoria
    Nodo* actual = lista;
    while (lista != NULL) {
        actual = lista;
        lista = lista->sgte;
        delete actual;
    }




    return 0;
}
