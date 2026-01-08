%   1)
buenaAccion(ayudar(_)).
buenaAccion(favor(_)).

malaAccion(golpear(_)).
malaAccion(travesura(Numero)):-
    Numero > 3.

%   2)
sePortoBien(Persona):-
    persona(Persona,_),
    forall(accion(Persona, Accion), not(malaAccion(Accion))).
    
%   3)
malcriador(Padre):-
    padre(Padre,_),
    forall(padre(Padre,Hijo), esMalcriado(Hijo)).

esMalcriado(Hijo):-
    forall(accion(Hijo, Accion), not(buenaAccion(Accion))).

esMalcriado(Hijo):-
    not(creeEnPapaNoel(Hijo)).

creeEnPapaNoel(federico).
creeEnPapaNoel(Persona):-
    persona(Persona, Edad),
    Edad < 13.

%   4)
puedeCostear(Padre, Hijo) :-
    padre(Padre, Hijo),
    presupuesto(Padre, Presupuesto),
    costoTotalDeseos(Hijo, CostoTotal),
    Presupuesto >= CostoTotal.

% Calcula el costo total de todos los deseos de una persona
costoTotalDeseos(Persona, CostoTotal) :-
    findall(Costo, costoDeseo(Persona, Costo), Costos),
    sumlist(Costos, CostoTotal).

% Calcula el costo individual de cada deseo
costoDeseo(Persona, Costo) :-
    quiere(Persona, Deseo),
    costo(Deseo, Costo).

% Costo de diferentes tipos de regalos
costo(abrazo, 0).  % Los abrazos son gratis

costo(juguete(_, Precio), Precio).  % Juguetes tienen precio definido

costo(bloques(Piezas), Costo) :-
    length(Piezas, CantidadPiezas),
    Costo is CantidadPiezas * 3.  % 3 por pieza

%   5)
regaloCandidatoPara(Regalo, Hijo):-
    sePortoBien(Hijo),
    padre(Padre, Hijo),
    puedePagar(Padre, Regalo),
    quiere(Hijo, Regalo),
    creeEnPapaNoel(Hijo).

puedePagar(Padre, Regalo):-
    presupuesto(Padre, Presupuesto),
    costo(Regalo, Costo),
    Presupuesto >= Costo.

%   6)


regalosQueRecibe(Hijo, ListaRegalos):-
    padre(Padre, Hijo),
    puedeCostear(Padre,Hijo),
    recibe(ListaRegalos).

regalosQueRecibe(Hijo, medias[gris,blanca]):-
    sePortoBien(Hijo).

regalosQueRecibe(Hijo, carbon):-
    minimoDosAcciones(Hijo).

minimoDosAcciones(Hijo):-
    accion(Hijo, UnaAccion),
    malaAccion(UnaAccion),
    accion(Hijo, OtraAccion),
    malaAccion(OtraAccion).


/* 
7) sugarDaddy/1 es verdadero para un padre si todos sus hijos quieren regalos caros o que valen la pena.
Actualmente un regalo es caro si cuesta mas de $500. Ademas: 
- Un juguete vale la pena si es buzz o woody
- Los bloquesitos si tienen un cubo 
- Los abrazos nunca valen la pena
*/

sugarDaddy(Padre):-
    padre(Padre,_),
    forall((padre(Padre,Hijo), quiere(Hijo, Regalo)), regaloAceptable(Regalo)).

regaloAceptable(Regalo):-
    esRegaloCaro(Regalo).

regaloAceptable(Regalo):-
    valeLaPena(Regalo).

esRegaloCaro(Regalo):-
    costo(Regalo, Costo),
    Costo > 500.

valeLaPena(juguete(buzz, _)).
valeLaPena(juguete(woody,_)).

valeLaPena(bloques(Bloquesitos)):-
    member(cubo, Bloquesitos).

