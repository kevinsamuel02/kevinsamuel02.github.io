/*Desarrolle los siguientes subprogramas:
     a) Una funcion que retorne una lista ordenada a partir de la union de una pila y una cola.
     b) Un procedimiento que genere una lista sin orden a partir de la interseccion de 2 listas.
 Defina usted las precondiciones y estructuras de los nodos de la manera que considere mas conveniente y detallar.*/



#include <iostream>

using namespace std;

struct Nodo
{
    int dato;
    Nodo *sgte;
};
void agregarLista1 (Nodo *&lista1, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo -> dato=n;
    nuevoNodo->sgte = lista1;
    lista1 = nuevoNodo;
}
void imprimirLista1(Nodo* lista1) {
    while (lista1 != NULL) {
        cout << lista1->dato << " ";
        lista1 = lista1->sgte;
    }
    cout << endl;
}
void agregarLista2 (Nodo *&lista2, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo -> dato=n;
    nuevoNodo->sgte = lista2;
    lista2 = nuevoNodo;
}
void imprimirLista2(Nodo* lista2) {
    while (lista2 != NULL) {
        cout << lista2->dato << " ";
        lista2 = lista2->sgte;
    }
    cout << endl;
}
void agregarLista3 (Nodo *&lista3, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo -> dato=n;
    nuevoNodo->sgte = lista3;
    lista3 = nuevoNodo;
}
void imprimirLista3(Nodo* lista3) {
    while (lista3 != NULL) {
        cout << lista3->dato << " ";
        lista3 = lista3->sgte;
    }
    cout << endl;
}
void interseccionListas (Nodo *&lista1, Nodo *&lista2, Nodo*&lista3)
{
    while (lista1 !=NULL)
    {
        Nodo *aux= lista2;
        while (aux != NULL)
        {
            if (aux->dato == lista1 ->dato)
            {
                agregarLista3 (lista3, aux->dato);
            }
            aux = aux ->sgte;
        }
        lista1 = lista1 ->sgte;
    }
}
void agregarLista (Nodo *&lista, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo -> dato=n;
    nuevoNodo->sgte = lista;
    lista = nuevoNodo;
}
void imprimirLista(Nodo* lista) {
    while (lista != NULL) {
        cout << lista->dato << " ";
        lista = lista->sgte;
    }
    cout << endl;
}
void ordenarLista (Nodo *&lista)
{
    if (lista == NULL || lista->sgte ==NULL) return;

    Nodo *actual = lista;
    Nodo *posterior = NULL;
    int aux;

    while (actual != NULL)
    {
        posterior = actual->sgte;
        while (posterior != NULL)
        {
            if (actual->dato > posterior ->dato)
            {
                aux = actual ->dato;
                actual-> dato = posterior -> dato;
                posterior->dato = aux;
            }
            posterior = posterior->sgte;
        }
        actual = actual->sgte;
    }
}
void insertarPila (Nodo *&pila, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo ->dato = n;
    nuevoNodo ->sgte = pila;
    pila = nuevoNodo;
}
bool colaVacia (Nodo *frente)
{
    return (frente == NULL);
}
void insertarCola (Nodo *&frente, Nodo *&fin, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo ->dato = n;
    nuevoNodo ->sgte = NULL;

    if (colaVacia(frente))
    {
        frente = nuevoNodo;
    } else {
    fin->sgte = nuevoNodo;
    }
    fin = nuevoNodo;
}

void PilaYCola (Nodo *&lista, Nodo *&pila, Nodo*&frente, Nodo*&fin)
{
    while (!colaVacia(frente))
    {
        agregarLista (lista, frente->dato);
        Nodo *aux = frente;
        frente = frente ->sgte;
        delete aux;
    }

    while (pila != NULL)
    {
        agregarLista (lista, pila->dato);
        Nodo *aux = pila;
        pila = pila ->sgte;
        delete aux;
    }
}


int main()
{
    Nodo* lista1 = NULL;
    Nodo* lista2 = NULL;
    Nodo* lista3 = NULL;
    Nodo* lista = NULL;
    Nodo *pila = NULL;
    Nodo* frente = NULL;
    Nodo* fin = NULL;

    insertarPila (pila, 5);
    insertarPila (pila, 1);
    insertarPila (pila, 51);

    insertarCola(frente, fin, 3);
    insertarCola(frente, fin, 8);
    insertarCola(frente, fin, 1);

    agregarLista1 (lista1, 5);
    agregarLista1 (lista1, 3);
    agregarLista1 (lista1, 1);

    agregarLista2 (lista2, 3);
    agregarLista2 (lista2, 1);
    agregarLista2 (lista2, 5);

     cout << "Lista 1: ";
    imprimirLista1(lista1);

     cout << "Lista 2: ";
    imprimirLista2(lista2);

    interseccionListas (lista1,lista2,lista3);

    cout << "Los numeros que se intersectan de las dos listas son: ";
    imprimirLista3 (lista3);

    PilaYCola(lista,pila,frente,fin);

    cout << "Lista no ordenada: ";
    imprimirLista(lista);

    ordenarLista(lista);

    cout << "Lista ordenada: ";
    imprimirLista(lista);

    // Liberar memoria
    Nodo* actual = lista;
    while (lista != NULL) {
        actual = lista;
        lista = lista->sgte;
        delete actual;
    }


    return 0;
}
