/*Crear una lista que almacene "n" números reales  y calcular su suma y promedio.*/



#include <iostream>
#include <conio.h>
#include <stdlib.h>

using namespace std;

struct Nodo
{
    double info;
    Nodo *sgte=NULL;
};

double sumar=0;
double prom = 0;
double cont =0;


void insertarLista(Nodo *&lista,double n){
	Nodo *nuevoNodo=new Nodo();
	nuevoNodo->info = n;

	Nodo *aux=lista;

	if(lista==NULL)
		lista=nuevoNodo;
	else
	{
		while(aux->sgte!=NULL)
			aux=aux->sgte;
		aux->sgte=nuevoNodo;
	}




	cout<<"Elemento "<< n <<" insertado a lista correctamente\n";
}


int suma (Nodo *&lista, double n)
{
    sumar = n + sumar;
    cont ++;
    return sumar;
}

double promedio (Nodo *&lista, int cont, int sumar)
{
    prom = sumar / cont;
    return prom;
}

int main()
{
    int t;
    double info;
    Nodo *inicio = NULL;


    cout << "Cuantos numeros desea ingresar? ";
    cin >> t;

    for (int i=0;i<t;i++)
    {
        cout << "Ingrese un numero: ";
        cin >> info;
        insertarLista (inicio,info);
        suma (inicio,info);
    }
    cout << "La suma es igual a: " << sumar << endl;
    cout << "El promedio es igual a: " << promedio (inicio,cont,sumar);



    return 0;
}
