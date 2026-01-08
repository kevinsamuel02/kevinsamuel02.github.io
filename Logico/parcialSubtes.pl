linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

% 1) estaEn/2: en qué línea está una estación.
estaEn(Linea, Estacion):-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).


% 2) distancia/3: dadas dos estaciones de la misma línea, cuántas estaciones 
% hay entre ellas: por ejemplo, entre Perú y Primera Junta hay 5 estaciones.

distancia(Linea, Estacion1, Estacion2):-
    mismaLinea(Estacion1, Estacion2),
    posicionEstacion(Posicion1, Estacion1),
    posicionEstacion(Posicion2, Estacion2),
    Distancia is Posicion1 - Posicion2,
    abs(Distancia, Resultado).

mismaLinea(Estacion1, Estacion2):-
    estaEn(Linea, Estacion1),
    estaEn(Linea, Estacion2).

% 3) mismaAltura/2: dadas dos estaciones de distintas líneas,
% si están a la misma altura (o sea, las dos terceras, las dos quintas, etc.), 
% por ejemplo: Pellegrini y Santa Fe están ambas segundas.

mismaAltura(Estacion1, Estacion2):-
    not(mismaLinea(Estacion1, Estacion2)),
    posicionEstacion(Posicion, Estacion1),
    posicionEstacion(Posicion, Estacion2).
    
    
posicionEstacion(Posicion, Estacion):-
    estaEn(Linea, Estacion)
    linea(Linea, Estaciones),
    nth1(Posicion, Estaciones, Estacion).


% 4)granCombinacion/1: se cumple para una combinación de más de dos estaciones.

granCombinacion(Combinacion):-
    combinacion(Combinacion),
    length(Combinacion, Cantidad),
    Cantidad > 2.


% 5)cuantasCombinan/2: dada una línea, relaciona esa línea con la cantidad de
% estaciones de esa línea que tienen alguna combinación. Por ejemplo, la línea C
% tiene 3 estaciones que combinan (avMayo, diagNorte e independenciaC).

cuantasCombinan(Linea, Cuantas):-
    linea(Linea, _),
    findall(Estaciones, combinaParaLinea(Estacion, Linea), ListaEstaciones),
    length(ListaEstaciones, Cantidad).

combinaParaLinea(Estacion, Linea) :-
    estaEn(Linea, Estacion),
    combinacion(Estaciones),
    member(Estacion, Estaciones).

% 6)lineaMasLarga/1: es verdadero para la línea con más estaciones.
lineaMasLarga(Linea) :-
    linea(Linea, Estaciones),
    length(Estaciones, Cuantas),
    forall(linea(_, OtrasEstaciones), menosEstacionesQue(Cuantas, OtrasEstaciones)).

menosEstacionesQue(Cuantas, Estaciones) :-
    length(Estaciones, OtrasCuantas),
    Cuantas >= OtrasCuantas.

% 7)viajeFacil/2: dadas dos estaciones, si puedo llegar fácil de una a la otra;
% esto es, si están en la misma línea, o bien puedo llegar con una sola combinación.
viajeFacil(Estacion1, Estacion2):-
    Estacion1 /= Estacion2,
    mismaLinea(Estacion1, Estacion2).

viajeFacil(Estacion1, Estacion2) :-
    combinacionPara(Estacion1, Combinacion1),
    combinacionPara(Estacion2, Combinacion2),
    mismaCombinacion(Combinacion1, Combinacion2).

combinacionPara(Estacion, Combinacion) :-
    estaEn(Linea, Estacion),
    linea(Linea, Estaciones),
    member(Combinacion, Estaciones).

mismaCombinacion(Estacion1, Estacion2) :-
    combinacion(Combinacion),
    member(Estacion1, Combinacion),
    member(Estacion2, Combinacion).