% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% …tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).


% 1) Definir el predicado esUnAfano/2, que nos dice si al jugar el primero contra el segundo,
% la diferencia de rating entre el primero y el segundo es mayor a 500.

esUnAfano(Jugador1, Jugador2):-
    jugador(Jugador1, Rating1,_),
    jugador(Jugador2, Rating2,_),
    Diferencia is Rating1 - Rating2,
    abs(Diferencia, Resultado),
    Resultado > 500.

/* 2) Definir el predicado esEfectivo/2, que relaciona dos unidades si la
 primera puede ganarle a la otra según su categoría, dado por el siguiente piedra, papel o tijeras:
a) La caballería le gana a la arquería.
b) La arquería le gana a la infantería.
c) La infantería le gana a los piqueros.
d) Los piqueros le ganan a la caballería.
Por otro lado, los Samuráis son efectivos contra otras unidades únicas (incluidos los samurái).
Los aldeanos nunca son efectivos contra otras unidades
*/

esEfectivo(Tipo1, Tipo2):-
    esMilitar(Tipo1, _, Categoria1),
    esMilitar(Tipo2, _, Categoria2),
    puedeGanarSegunCategoria(Categoria1, Categoria2).

esEfectivo(samurai, Tipo):-
    esMilitar(Tipo, _, unica).

puedeGanarSegunCategoria(caballeria, arqueria).
puedeGanarSegunCategoria(arqueria, infanteria).
puedeGanarSegunCategoria(infanteria, piqueros).
puedeGanarSegunCategoria(piqueros, caballeria).

esMilitar(Tipo, Costo, Categoria):-
    militar(Tipo, Costo, Categoria).

% 3) Definir el predicado alarico/1 que se cumple para un jugador si solo tiene unidades de infantería.
alarico(Jugador):-
    jugador(Jugador,_,_),
    soloTiene(infanteria, Jugador).
soloTiene(Categoria, Jugador):-
    forall(tiene(Jugador, unidad(Tipo, _)), militar(Tipo,_,Categoria)).

% 4) Definir el predicado leonidas/1, que se cumple para un jugador si solo tiene unidades de piqueros.
leonidas(Jugador):-
    jugador(Jugador,_,_),
    soloTiene(piqueros, Jugador).

% 5) Definir el predicado nomada/1, que se cumple para un jugador si no tiene casas.
nomada(Jugador):-
    jugador(Jugador,_,_),
    not(tiene(Jugador, edificio(casa,_))).

/*
 6) Definir el predicado cuantoCuesta/2, que relaciona una unidad o edificio con su costo.
 De las unidades militares y de los edificios conocemos sus costos. Los aldeanos cuestan 
 50 unidades de alimento. Las carretas y urnas mercantes cuestan 100 unidades de madera y
 50 de oro cada una.
*/

cuantoCuesta(Tipo, Costo):-
    esMilitar(Tipo, Costo, _).

cuantoCuesta(Tipo, Costo):-
    esEdificio(Tipo, Costo).

cuantoCuesta(Tipo, costo(0, 50, 0)):-
    esAldeano(Tipo, _).

cuantoCuesta(Tipo, costo(100, 0, 50)):-
    esCarretaOUrna(Tipo).

esCarretaOUrna(carreta).
esCarretaOUrna(urnaMercante).

esEdificio(Tipo, Costo):-
    edificio(Tipo, Costo).

esAldeano(Tipo, Produccion):-
    aldeano(Tipo, Produccion).

esMilitar(Tipo, Costo, Categoria):-
    militar(Tipo, Costo, Categoria).




/*
 7) Definir el predicado produccion/2, que relaciona una unidad con su producción de recursos por minuto.
 De los aldeanos, según su profesión, se conoce su producción. Las carretas y urnas mercantes producen
 32 unidades de oro por minuto. Las unidades militares no producen ningún recurso, salvo los Keshiks, que
 producen 10 de oro por minuto.
*/

produccion(Tipo, Produccion):-
    esAldeano(Tipo, Produccion).

produccion(Tipo, produce(0,0,32)):-
    esCarretaOUrna(Tipo).

produccion(keshiks, produce(0,0,10)).


/*
 8) Definir el predicado produccionTotal/3 que relaciona a un jugador con su producción total por minuto
 de cierto recurso, que se calcula como la suma de la producción total de todas sus unidades de ese
 recurso.
*/
produccionTotal(Nombre, Recurso, ProduccionTotalPorMinuto):-
    tiene(Nombre, _),
    recursos(Recurso),
    findall(Produccion, loTieneYProduce(Nombre, Recurso, Produccion), ListaDeProduccion),
    sum_list(ListaDeProduccion, ProduccionTotalPorMinuto).

loTieneYProduce(Nombre, Recurso, Produccion):-
    tiene(Nombre, unidad(Tipo, CuantasTiene)),
    produccion(Tipo, ProduccionTotal),
    produccionDelRecurso(Recurso, ProduccionTotal, ProduccionRecurso),
    Produccion is ProduccionRecurso * CuantasTiene.

produccionDelRecurso(madera, produccion(Madera, _, _), Madera).
produccionDelRecurso(alimento, produccion(_, Alimento, _), Alimento).
produccionDelRecurso(oro, produccion(_, _, Oro), Oro).

recursos(oro).
recursos(madera).
recursos(alimento).



/*
 9) Definir el predicado estaPeleado/2 que se cumple para dos jugadores cuando no es un afano para
ninguno, tienen la misma cantidad de unidades y la diferencia de valor entre su producción total de
recursos por minuto es menor a 100 . ¡Pero cuidado! No todos los recursos valen lo mismo: el oro vale
cinco veces su cantidad; la madera, tres veces; y los alimentos, dos veces.
*/

estaPeleado(Jugador1, Jugador2):-
    tiene(Jugador1, _),
    tiene(Jugador2, _),
    not(esUnAfano(Jugador1, Jugador2)),
    mismasUnidades(Jugador1, Jugador2),
    diferenciaMenorA100(Jugador1, Jugador2).

mismasUnidades(Jugador1, Jugador2):-
    findall(Unidad, tiene(Jugador1, unidad(_, Unidad)), Unidades),
    findall(Uni, tiene(Jugador2, unidad(_, Uni)), Unis),
    sum_list(Unidades, Total1),
    sum_list(Unis, Total1).

diferenciaMenorA100(Jugador1, Jugador2):-
    produccionRecursosTotales(Jugador1, Total1),
    produccionRecursosTotales(Jugador2, Total2),
    Diferencia is Total1 - Total2,
    abs(Diferencia, Resultado),
    Resultado < 100.

produccionRecursosTotales(Jugador, Total):-
    produccionTotal(Jugador, Oro, ProduOro),
    produccionTotal(Jugador, Madera, ProduMadera),
    produccionTotal(Jugador, Alimento, ProduAlimento),
    ValorMadera is ProduMadera * 3,    % Madera vale 3 veces
    ValorAlimento is ProduAlimento * 2, % Alimento vale 2 veces
    ValorOro is ProduOro * 5, 
    Total is ValorOro + ValorMadera + ValorAlimento.



/*
 10) Definir el predicado avanzaA/2 que relaciona un jugador y una edad si este puede avanzar a ella:
a) Siempre se puede avanzar a la edad media.
b) Puede avanzar a edad feudal si tiene al menos 500 unidades de alimento y una casa.
c) Puede avanzar a edad de los castillos si tiene al menos 800 unidades de alimento y 200 de oro.
También es necesaria una herrería, un establo o una galería de tiro.
d) Puede avanzar a edad imperial con 1000 unidades de alimento, 800 de oro, un castillo y una
universidad.
*/

avanzaA(Jugador, edadMedia):-
    jugador(Jugador,_,_).


avanzaA(Jugador, edadFeudal):-
    jugador(Jugador,_, _),
    tieneAlMenosAlimento(Jugador, 500),
    tiene(Jugador, edificio(casa, _)).

avanzaA(Jugador, edadDeLosCastillos):-
    jugador(Jugador,_, _),
    tieneAlMenosAlimento(Jugador, 800),
    tieneAlMenosOro(Jugador, 200),
    tieneEstabloHerreriaOGaleriaDeTiro(Jugador).


avanzaA(Jugador, edadImperial):-
    jugador(Jugador,_, _),
    tieneAlMenosAlimento(Jugador, 1000),
    tieneAlMenosOro(Jugador, 800),
    tiene(Jugador, edificio(castillo,_)),
    tiene(Jugador, edificio(universidad,_)).

    

tieneEstabloHerreriaOGaleriaDeTiro(Jugador):-
    tiene(Jugador, edificio(herreria,_)).

tieneEstabloHerreriaOGaleriaDeTiro(Jugador):-
    tiene(Jugador, edificio(establo,_)).

tieneEstabloHerreriaOGaleriaDeTiro(Jugador):-
    tiene(Jugador, edificio(galeriaDeTiro,_)).

tieneAlMenosAlimento(Jugador, Cantidad):-
    tiene(Jugador, recurso(_,Recurso,_)),
    Recurso >= Cantidad.

tieneAlMenosOro(Jugador, Cantidad):-
    tiene(Jugador, recurso(_,_,Recurso)),
    Recurso >= Cantidad.


