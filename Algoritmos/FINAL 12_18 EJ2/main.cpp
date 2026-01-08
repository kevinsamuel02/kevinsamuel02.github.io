#include <iostream>

using namespace std;

struct Alumno
{
    int legajo;
    int nota1Parcial;
    int nota2Parcial;
}alumno[1500];

struct Lista
{
    int legajo;
    int notaRecuperatorio2Parcial;
}lista[1500];

void actualizarNotas ()
{
  for (int i=0;i<1500;i++)
{
    for (int j=0;j<1500;j++)
    {
        if ((lista[j].legajo == alumno[i].legajo)&&(lista[j].notaRecuperatorio2Parcial >= 6))
        {
            alumno [i].nota2Parcial = lista[j].notaRecuperatorio2Parcial;
            break;
        }
    }

  }

}


int main()
{
    alumno[0] = {1001, 8,6};
    lista[0] = {1001, 8};

    // Llamada a la función de actualización
    actualizarNotas();

    // Verificación de la actualización
    cout << "Legajo: " << alumno[0].legajo << ", Nota 2° Parcial: " << alumno[0].nota2Parcial << endl;


    return 0;
}
