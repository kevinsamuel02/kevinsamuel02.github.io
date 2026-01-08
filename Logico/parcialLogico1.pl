persona(kevin, 19, masculino).
persona(biluanky, 34, femenino).
persona(uenche, 18, masculino).

generosDeInteres(kevin, [femenino]).
generosDeInteres(biluanky, [masculino]).
generosDeInteres(uenche, [masculino, femenino]).

rangoEdad(kevin, 19, 25).
rangoEdad(biluanky, 18, 49).
rangoEdad(uenche, 25, 37).

gustos(kevin, [futbol,cocinar,sushi,asado,boca]).
gustos(biluanky,[sistemas, ciencia, pija, cigarrillos, laJefaDeTp]).
gustos(uenche,[alcohol, drogas, dildos]).

disgustos(kevin, [river, tomate, aceitunas, estudiar, pija]).
disgustos(biluanky, [preguntasBoludas, downs, celulares, desprolijidad, disrespect]).

persona(Persona):-
    persona(Persona,_,_).


%-----------------------------
%------Perfil Incompleto------
%----------------------------- 


perfilIncompleto(Persona):-
    persona(Persona),
    not(datosCompletos(Persona)).

perfilIncompleto(Persona):-
    persona(Persona),
    not(mayorEdad(Persona)).

datosCompletos(Persona):-
    persona(Persona),
    generosDeInteres(Persona,_),
    rangoEdad(Persona,_,_),
    gustos(Persona, Gustos),
    alMenosCinco(Gustos),
    disgustos(Persona, Disgustos),
    alMenosCinco(Disgustos).

alMenosCinco(Lista):-
    length(Lista, Cantidad),
    Cantidad >= 5.

mayorEdad(Persona):-
    persona(Persona, Edad, _),
    Edad >= 18.


%-----------------------------
%----------Alma Libre---------
%-----------------------------


almaLibre(Persona):-
    persona(Persona),
    forall(persona(_,_,Genero), sienteInteresRomantico(Persona, Genero)).

almaLibre(Persona):-
    persona(Persona),
    aceptaPretendientes(Persona).

aceptaPretendientes(Persona):-
    rangoEdad(Persona, Num1, Num2),
    Rango is Num2 - Num1,
    Rango >= 30.

sienteInteresRomantico(Persona, Genero):-
    generosDeInteres(Persona, GustosPersona),
    member(Genero, GustosPersona).

    %-----------------------------
%-----Quiere la herencia------
%----------------------------- 


quiereLaHerencia(Persona):-
    persona(Persona),
    diferenciaMayorA30(Persona).

diferenciaMayorA30(Persona):-
    persona(Persona,Edad,_),
    rangoEdad(Persona, Minimo,_),
    Diferencia is Minimo - Edad,
    Diferencia >= 30.



%-----------------------------
%---------Indeseable----------
%----------------------------- 

indeseable(Persona):-
    persona(Persona),
    not(pretendiente(Persona, _)).

    %-----------------------------
%---------Pretendiente--------
%----------------------------- 


pretendiente(Persona, Pretendiente):-
    persona(Persona, Edad, Genero1),
    persona(Pretendiente, EdadPretendiente, Genero2),
    generosDeInteres(Persona, Lista),
    member(Genero2, Lista),
    rangoEdad(Persona, Minima, Maxima),
    EdadPretendiente >= Minima,
    EdadPretendiente <= Maxima,
    alMenosUno(Persona, Pretendiente).

alMenosUno(Persona, Pretendiente):-
    gustos(Persona, Gustos1),
    gustos(Pretendiente, Gustos2),
    member(X, Gustos1),
    member(X, Gustos2).

%-----------------------------
%-----------Hay Match---------
%----------------------------- 


hayMatch(Persona, Pretendiente):-
    persona(Persona),
    persona(Pretendiente),
    pretendiente(Persona, Pretendiente),
    pretendiente(Pretendiente, Persona).

%-----------------------------
%------Triangulo Amoroso------
%----------------------------- 


trianguloAmoroso(Persona1, Persona2, Persona3):-
    persona(Persona1),
    persona(Persona2),
    persona(Persona3),
    pretendienteSinMatch(Persona1 , Persona2),
    pretendienteSinMatch(Persona3 , Persona1),
    pretendienteSinMatch(Persona2 , Persona3).

pretendienteSinMatch(Persona1 , Persona2):-
    pretendiente(Persona1 , Persona2),
    not(hayMatch(Persona1 , Persona2)). 


%-----------------------------
%-----El Uno Para El Otro-----
%----------------------------- 

unoParaElOtro(UnaPersona , OtraPersona):-
    persona(UnaPersona),
    persona(OtraPersona),
    hayMatch(UnaPersona , OtraPersona),
    noHayGustoQueDisgustenMutuamente(UnaPersona , OtraPersona).

noHayGustoQueDisgustenMutuamente(UnaPersona , OtraPersona):-
    noHayGustoQueDisguste(UnaPersona , OtraPersona),
    noHayGustoQueDisguste(OtraPersona , UnaPersona).

noHayGustoQueDisguste(UnaPersona , OtraPersona):-
    gustos(UnaPersona , Gustos),
    disgustos(OtraPersona , Disgustos),
    forall(member(Gusto , Gustos) , not(member(Gusto , Disgustos))). 


%-----------------------------
%-------Indice de Amor--------
%----------------------------- 

indiceDeAmor(uenche, biluanky, 5).
indiceDeAmor(biluanky, uenche, 8).
indiceDeAmor(biluanky, uenche, 9).
indiceDeAmor(biluanky, uenche, 7).

%-----------------------------
%----------Desbalance---------
%-----------------------------

desbalance(Persona1 , Persona2):-
    persona(Persona1),
    persona(Persona2),
    promedioIndiceDeAmor(Persona1 , Persona2 , PromedioPersona1 ,PromedioPersona2),
    desbalanceEntrePromedios(PromedioPersona1 , PromedioPersona2).

promedioIndiceDeAmor(Persona1 , Persona2 , PromedioPersona1 ,PromedioPersona2):-
    promedioIndiceDeAmorDeCadaUno(Persona1 , Persona2 , PromedioPersona1),
    promedioIndiceDeAmorDeCadaUno(Persona2 , Persona1 , PromedioPersona2).

promedioIndiceDeAmorDeCadaUno(Persona1 , Persona2 , PromedioPersona1):-
    findall(Indice , indiceDeAmor(Persona1 , Persona2 , Indice) , Indices),
    sumlist(Indices , SumaIndices),
    length(Indices , CantidadDeMensajes),
    CantidadDeMensajes > 0,
    Promedio is SumaIndices / CantidadDeMensajes.


desbalanceEntrePromedios(PromedioPersona1 , PromedioPersona2):-
    unPromedioEsMasDelDobleQueOtro(PromedioPersona1 , PromedioPersona2).

desbalanceEntrePromedios(PromedioPersona1 , PromedioPersona2):-
    unPromedioEsMasDelDobleQueOtro(PromedioPersona2 , PromedioPersona1).

unPromedioEsMasDelDobleQueOtro(Promedio1 , Promedio2):-
    DobleDelPromedio2 is Promedio2 * 2,
    Promedio1 > DobleDelPromedio2

%-----------------------------
%-----------Ghosteo-----------
%----------------------------- 
ghosteaA(Ghosteado , Ghoster):-
    persona(Ghosteado),
    persona(Ghoster),
    indiceDeAmor(Ghosteado , Ghoster , _),
    not(indiceDeAmor(Ghoster , Ghosteado , _)). 
