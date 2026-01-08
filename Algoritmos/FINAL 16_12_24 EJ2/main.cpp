#include <iostream>

using namespace std;

struct Matriculas
{
    int codigoCurso;
    int cantAlum;
    int monto;
}matriculas[30];

struct NodoReservas
{
    int codigoCurso;
    int monto;
    NodoReservas *sgte;
};

void actualizarDatos (NodoReservas *listaReservas)
{
    NodoReservas *aux = listaReservas;

    while (aux!=NULL)
    {
        for (int i=0;i<30;i++)
        {
            if (matriculas[i].codigoCurso == aux->codigoCurso)
            {
                matriculas[i].cantAlum ++;
                matriculas [i].monto += aux ->monto;
            }
        }
        aux = aux->sgte;
    }
}


int main()
{




    return 0;
}
