#include <iostream>

using namespace std;

const int n = 4;

int matrizDistancia [n][n] =
{

{0,10,15,20},
{10,0,25,30},
{15,25,0,35},
{20,30,35,0
}
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
    ciudadA=0;
    ciudadB=1;
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



int main()
{
    int ciudadA,ciudadB;
    int distanciaMasLarga;

    MasAlejadas (matrizDistancia, ciudadA, ciudadB, distanciaMasLarga);
    cout << "La distancia mas larga la tienen la ciudad " << ciudadA << " y " << ciudadB << " con una distancia de " << distanciaMasLarga << endl;
    cout << "La suma de la diagonal es de " << Diagonal (matrizDistancia);



    return 0;
}
