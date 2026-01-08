/*Desarrolle una funcion que retorne una lista ordenada a partir de la union de 1 cola y 1 vector.
Defina usted las precondiciones y estructuras de los nodos de la manera que considere mas conveniente y detallar.*/


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
    nuevoNodo ->dato= n;
    nuevoNodo->sgte=NULL;

    if (frente == NULL)
    {
        frente = nuevoNodo;
    } else {
            fin->sgte = nuevoNodo;
    }
    fin =nuevoNodo;
}

bool colaVacia (Nodo *frente)
{
    return (frente == NULL);
}



void insertarLista (Nodo *&lista, int valor)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo ->dato=valor;
    nuevoNodo->sgte=lista;
    lista=nuevoNodo;
}

void mostrarLista(Nodo* lista) {
    Nodo* actual = lista;
    while (actual != NULL) {
        cout << actual->dato << " ";
        actual = actual->sgte;
    }
    cout << endl;
}
void unirColaYVector (Nodo *&lista, int *vec, int tam, Nodo *&frente, Nodo *&fin)
{
    while (!colaVacia(frente))
    {
        insertarLista (lista,frente->dato);
        Nodo *aux=frente;
        frente = frente ->sgte;
        delete aux;
    }
    for (int i=0;i < tam;i++)
    {
        insertarLista(lista,vec[i]);
    }
}
void ordenarLista (Nodo *&lista)
{
    if ((lista == NULL)||(lista->sgte == NULL))return;

    Nodo *actual = lista;
    Nodo *siguiente =NULL;
    int aux;


    while (actual != NULL)
    {
        siguiente = actual ->sgte;
        while (siguiente != NULL)
        {
            if (actual->dato < siguiente->dato)
            {
                aux = actual -> dato;
                actual -> dato = siguiente -> dato;
                siguiente -> dato = aux;
            }
            siguiente = siguiente->sgte;
        }
        actual = actual->sgte;
    }

}

int main()
{
    Nodo* lista = NULL;
    int vec[] = {1, 13, 5, 8};
    int vecTam = 4;
    Nodo* frente = NULL;
    Nodo* fin = NULL;

    insertarCola(frente, fin, 3);
    insertarCola(frente, fin, 8);
    insertarCola(frente, fin, 1);

    unirColaYVector(lista, vec, vecTam, frente, fin);

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
