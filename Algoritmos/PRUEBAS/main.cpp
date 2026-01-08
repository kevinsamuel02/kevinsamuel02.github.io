#include <iostream>

using namespace std;

const int n = 4;

int matrizDistancia [n][n] =
{

{0,10,15,20},
{10,0,25,30},
{15,25,0,35},
{20,30,35,0}
};

int Diagonal (int matriz [n][n])
{
    int suma =0;
    for (int i=0;i<n;i++)
    {
        suma += matriz [i][i];
    }
    return suma;
}

void MasAlejadas (int matriz [n][n], int &ciudadA, int &ciudadB, int &distanciaMasLarga)
{
    distanciaMasLarga =0;
    ciudadA=1;
    ciudadB=0;
    for (int i=0;i<n;i++)
    {
        for (int j=0;j<n;j++)
        {
            if (i != j && matriz [i][j] > distanciaMasLarga)
            {
                distanciaMasLarga = matriz [i][j];
                ciudadA = i+1;
                ciudadB = j+1;
            }
        }
    }
    return;
}
struct Nodo
{
    int info;
    Nodo *sgte;
};
Nodo *interListas (Nodo *lista1,Nodo*lista2)
{
    Nodo *listaResultado = NULL;
    Nodo *aux1=lista1;
    while (aux1!=NULL)
    {
        Nodo *aux2 = lista2;
        while (aux2!=NULL)
        {
            if (aux2->info==aux1->info)
            {
                insertarLista (listaResultado,aux1->info);
            }
            aux2=aux2->sgte;
        }
        aux1=aux1->sgte;
    }
    return listaResultado;
}
struct Notas
{
    int legajo;
    int parcial1;
    int parcial2;
}notas[1500];

struct Recu
{
    int legajo;
    int recu2do;
}recu[1500];

void actualizarNotas ()
{
    for (int i = 0;i<1500;i++)
    {
        for (int j = 0;j<1500;j++)
        {
            if (recu[j].legajo==notas[i].legajo)
            {
                if(recu[j].recu2do>=6)
                {
                    notas[i].parcial2= recu[j].recu2do;
                }
                break;
            }
        }
    }
    return;
}

struct Nodo
{
    int info; Nodo *sgte;
};

int main()
{
    Nodo *p=NULL; Nodo*aux;
    p = new Nodo();
    p->info = 1; p->sgte = new Nodo();
    p->sgte->info=2; p->sgte->sgte =new Nodo();
    p->sgte->sgte->info=3;p->sgte->sgte->sgte=NULL;
    aux=p;
    p=p->sgte;
    p->sgte->sgte=aux;
    aux->sgte = NULL;
    aux=p;
    while (aux)
    {
        cout << aux->info << ", ";
        aux=aux->sgte;
    }
    return 0;
}





    int ciudadA,ciudadB;
    int distanciaMasLarga;

    MasAlejadas (matrizDistancia, ciudadA, ciudadB,distanciaMasLarga);
    cout << "La distancia mas larga la tienen la ciudad " << ciudadA << " y " << ciudadB << " con una distancia de " << distanciaMasLarga << endl;
    cout << "La suma de la diagonal es de " << Diagonal (matrizDistancia);



    return 0;
}
