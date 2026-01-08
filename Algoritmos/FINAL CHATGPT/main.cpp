/*Se tiene un vector con los artículos de una tienda, INVENTARIO, que contiene todos los artículos
que están disponibles para la venta, con los siguientes campos: Código del artículo, Categoría
('E'=electrónico, 'R'=ropa), y Cantidad en existencia. Además, se cuenta con una lista ordenada que
contiene las últimas órdenes procesadas, donde se detalla el Código del artículo, el Cliente que
realizó la compra y las cantidades solicitadas. Se pide: actualizar el vector INVENTARIO con la
información que hay en la lista, SOLO para el campo Cantidad. Se sabe que como máximo hay 50 artículos en el inventario.*/


#include <iostream>

using namespace std;

struct Inventario
{
    int codArt;
    char categoria; // 'E' (electronico) y 'R' (ropa)
    int cantExist;
}inventario[50];
struct ultOrdenes
{
    int codArt;
    int cliente;
    int cantSoli;
    ultOrdenes * sgte;
};

void actualizarInventario (ultOrdenes *lista)
{
    ultOrdenes *aux= lista;
    int dato;

    while (aux!=NULL)
    {
        for (int i=0;i<50;i++)
        {
            if (inventario[i].codArt == aux->codArt)
            {
                inventario[i].cantExist -= aux->cantSoli;
            }
        }
        aux = aux->sgte;
    }
}

int main()
{



    return 0;
}
