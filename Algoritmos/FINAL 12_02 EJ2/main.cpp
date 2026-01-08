/*Se tiene un vector de los productos de un almacen, STOCK, que contiene todos los productos que se tienen
disponibles a la venta, con los siguientes campos: ID del producto, Tipo ('P' perecedero y 'N' no perecedero) y
Unidades en el almacen, Ademas, se cuenta con una lista ordenada que contiene los ultimos pedidos al almacen
que deben ser entregados a los clientes finales. La lista contiene el ID del producto, el ID del cliente y las unidades
requqeridas.
Se pide, actualizar el vector STOCK con la informacion que hay en la lista, SOLO para el campo Unidades.
SE SABE QUE COMO MAXIMO HAY 50 PRODUCTOS.*/



#include <iostream>

using namespace std;
struct Lista
{
    int idProducto;
    int idCliente;
    int unidadesReq;
}lista[50];
struct Stock
{
    int idProducto;
    char tipo; //'P' perecedero y 'N' no perecedero
    int unidades;
}stock[50];


void actualizarStock ()
{
    for (int i=0;i<50;i++)
    {
        for(int j=0;j<50;j++)
        {
            if (lista[j].idProducto == stock[i].idProducto)
            {
                if (stock [i].unidades >= lista[j].unidadesReq)
                {
                    stock [i].unidades -= lista[j].unidadesReq;
                } else
                {
                    stock[i].unidades = 0;
                }
            }
        }

    }
}

int main()
{
     stock[0] = {1000,'N',5};
    lista[0] = {1000,12,3};

    // Llamada a la función de actualización
    actualizarStock();

    // Verificación de la actualización
    cout << "Id del producto: " << stock[0].idProducto << ", Unidades: " << stock[0].unidades << endl;



    return 0;
}











