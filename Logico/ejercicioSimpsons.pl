padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

tieneHijo(Madre) :-
    madreDe(Madre, _).

tieneHijo(Padre) :-
    padreDe(Padre, _).

hermanos(Hijo1, Hijo2) :-
    madreDe(Madre, Hijo1),
    madreDe(Madre, Hijo2),
    padreDe(Padre, Hijo1),
    padreDe(Padre, Hijo2).

medioHermanos(Hijo1, Hijo2) :-
    madreDe(Madre, Hijo1),
    madreDe(Madre, Hijo2).

medioHermanos(Hijo1, Hijo2) :-
    padreDe(Madre, Hijo1),
    padreDe(Madre, Hijo2).

tioDe(Tio) :-
    madreDe(Abuela, Madre),
    madreDe(Abuela, Tio),
    madreDe

    

