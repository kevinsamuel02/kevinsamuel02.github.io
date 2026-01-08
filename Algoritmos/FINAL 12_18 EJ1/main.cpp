/*Desarrolle una funcion que retorne una lista ordenada a partir de la union de 1 cola y 1 pila.
Defina usted las precondiciones y estructuras de los nodos de manera que considere mas conveniente detallar*/

#include <iostream>

using namespace std;

struct Nodo
{
    int dato;
    Nodo *sgte;
};

void insertarCola (Nodo *&frente, Nodo *&fin, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo->dato = n;
    nuevoNodo->sgte= NULL;


    if (frente == NULL)
    {
        frente = nuevoNodo;
    } else
    {
        fin ->sgte = nuevoNodo;
    }
    fin = nuevoNodo;
}

bool colaVacia (Nodo *frente)
{
    return (frente == NULL);
}

void insertarPila (Nodo *&pila, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo->dato = n;
    nuevoNodo ->sgte = pila;
    pila = nuevoNodo;
}

void insertarLista (Nodo *&lista, int n)
{
    Nodo *nuevoNodo = new Nodo();
    nuevoNodo->dato=n;
    nuevoNodo->sgte=lista;
    lista = nuevoNodo;
}

void mostrarLista(Nodo* lista) {
    Nodo* actual = lista;
    while (actual != NULL) {
        cout << actual->dato << " ";
        actual = actual->sgte;
    }
    cout << endl;
}
void pilaYCola (Nodo *&lista,Nodo *&pila, Nodo *&frente, Nodo *&fin)
{
    while (!colaVacia(frente))
    {
        insertarLista (lista, frente->dato);
        Nodo *aux = frente;
        frente = frente-> sgte;
        delete aux;
    }

    while (pila != NULL)
    {
        insertarLista (lista, pila->dato);
        Nodo *aux = pila;
        pila = pila ->sgte;
        delete aux;
    }
}

void ordenarLista (Nodo *&lista)
{
    if ((lista == NULL)||(lista->sgte == NULL))return;

    Nodo *actual= lista;
    Nodo *posterior = NULL;
    int aux;

    while (actual != NULL)
    {
        posterior = actual->sgte;
        while (posterior != NULL)
        {
            if (actual->dato < posterior->dato)
            {
                aux = actual->dato;
                actual->dato = posterior->dato;
                posterior->dato = aux;
            }
            posterior= posterior ->sgte;
        }
        actual = actual ->sgte;
    }
}

int main()
{
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

    pilaYCola(lista,pila,frente,fin);

    cout << "Lista no ordenada: ";
    mostrarLista(lista);

    ordenarLista(lista);

    cout << "Lista ordenada: ";
    mostrarLista(lista);

    // Liberar memoria
    Nodo* actual = lista;
    while (lista != NULL) {
        actual = lista;
        lista = lista->sgte;
        delete actual;
    }




    return 0;
}
