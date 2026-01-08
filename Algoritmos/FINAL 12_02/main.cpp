/*Desarrolle una FUNCION que retorne una lista ORDENADA a partir de la UNION de 1 cola y 1 vector.
Defina usted las precondiciones y estructuras de los nodos de la manera que considere mas conveniente detallar*/



#include <iostream>

using namespace std;

struct Nodo
{
    int dato;
    Nodo *sgte;
};
struct nodoCola
{
    Nodo *fin;
    Nodo *frente;
};

int vec[tam];//asumo que ya se declaro el tamano

Nodo *ColaVec (nodoCola*cola,int vec[])
{
    Nodo*lista;
    int dato;

    while (cola!=NULL)
    {
        dato= desencolar(cola->frente);//asumiendo que existe desencolar
        insertarOrdenado (lista,cola->frente);//asumo que InserarOrdenado ya se declaro
    }
    for (int i=0;i<30;i++)
    {
        insertarOrdenado(lista,vec[i]);
    }
    return lista;
}

void insertarCola (Nodo *&frente,Nodo *&fin, int n)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo->dato = n;
    nuevoNodo ->sgte = NULL;

    if (frente == NULL)
    {
        frente = nuevoNodo;
    } else
    {
        fin->sgte = nuevoNodo;
    }
    fin = nuevoNodo;
}

bool colaVacia (Nodo *frente)
{
    return (frente == NULL);
}

void insertarLista (Nodo *&lista, int info)
{
    Nodo *nuevoNodo = new Nodo ();
    nuevoNodo ->dato = info;
    nuevoNodo ->sgte = lista;
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

void colaYVector (Nodo *&lista, Nodo *&frente, Nodo *&fin, int *vec, int tam )
{
    while (!colaVacia(frente))
    {
        insertarLista (lista,frente->dato);
        Nodo *aux= frente;
        frente = frente ->sgte;
        delete aux;
    }

    for (int i=0;i<tam;i++)
    {
        insertarLista (lista,vec[i]);
    }
}

void ordenarLista (Nodo *&lista)
{
     if ((lista == NULL)||(lista ->sgte ==NULL)) return;

    Nodo *actual= lista;
    Nodo *posterior = NULL;
    int aux;


 while (actual != NULL)
 {
     posterior = actual->sgte;
     while (posterior != NULL)
     {
         if (actual ->dato < posterior->dato)
         {
             aux = actual->dato;
             actual->dato = posterior ->dato;
             posterior ->dato = aux;
         }
         posterior = posterior->sgte;
     }
     actual = actual ->sgte;
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

    colaYVector(lista,frente,fin,vec,vecTam);

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
