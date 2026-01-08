rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).
cocina(colette, ratatouille, 5).

trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).


grupo(frutillasConCrema).
grupo(chocotorta).
/* 1) inspeccionSatisfactoria/1 se cumple para un
restaurante cuando no viven ratas allí.
*/

inspeccionSatisfactoria(Restaurante):-
    trabajaEn(Restaurante,_),
    not(rata(_,Restaurante)).

% 2. chef/2: relaciona un empleado con un restaurante si el
% empleado trabaja allí y sabe cocinar algún plato.

chef(Empleado, Restaurante):-
    trabajaEn(Empleado, Restaurante),
    cocina(Empleado,_,_).

% 3. chefcito/1: se cumple para una rata si vive en el mismo
% restaurante donde trabaja linguini.

chefcito(Rata):-
    rata(Rata, Restaurante),
    trabajaEn(Restaurante, linguini).

% 4. cocinaBien/2 es verdadero para una persona si su experiencia preparando ese plato es mayor a 7.
% Además, remy cocina bien cualquier plato que exista.

cocinaBien(remy,_).

cocinaBien(Persona, Plato):-
    cocina(Persona, Plato, Experiencia),
    Experiencia > 7.

/* 5. encargadoDe/3: nos dice el encargado de cocinar un plato en un restaurante, que es quien más
experiencia tiene preparándolo en ese lugar.
*/

encargadoDe(Persona, Plato, Restaurante):-
    cocina(Persona,Plato,Experiencia),
    trabajaEn(Persona, Restaurante),
    forall((trabajaEn(Restaurante, Otro), cocina(Otro, Plato, ExpOtro)), ExpOtro =< ExperienciaMaxima).





plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).


/* 6. saludable/1: un plato es saludable si tiene menos de 75 calorías.
● En las entradas, cada ingrediente suma 15 calorías.
● Los platos principales suman 5 calorías por cada minuto de cocción. Las guarniciones agregan
a la cuenta total: las papasFritas 50 y el puré 20, mientras que la ensalada no aporta calorías.
● De los postres ya conocemos su cantidad de calorías.
Pero además, un postre también puede ser saludable si algún grupo del curso tiene ese nombre de
postre. Usá el predicado grupo/1 como hecho y da un ejemplo con tu nombre de grupo.
*/

saludable(Plato):-
    plato(Plato, _),
    sumaCalorias(Plato, Calorias),
    Calorias < 75.

saludable(Plato):-
    plato(Plato,postre(Calorias)),
    Calorias < 75.

saludable(Plato):-
    grupo(Plato).


sumaCalorias(Plato, Calorias):-
    plato(Plato, entrada([Ingredientes])),
    length(Ingredientes, Cantidad),
    Calorias is Cantidad * 15.

sumaCalorias(Plato, Calorias):-
    plato(Plato, principal(pure, Tiempo)),
    Calorias is Tiempo * 5 + 20.

sumaCalorias(Plato, Calorias):-
    plato(Plato, principal(papasFritas, Tiempo)),
    Calorias is Tiempo * 5 + 50.

sumaCalorias(Plato, Calorias):-
    plato(Plato, principal(ensalada, Tiempo)),
    Calorias is Tiempo * 5.

/* 7. criticaPositiva/2: es verdadero para un restaurante si un crítico le escribe una reseña positiva.
Cada crítico maneja su propio criterio, pero todos están de acuerdo en lo mismo: el lugar debe tener
una inspección satisfactoria.
● antonEgo espera, además, que en el lugar sean especialistas preparando ratatouille. Un
restaurante es especialista en aquellos platos que todos sus chefs saben cocinar bien.
● christophe, que el restaurante tenga más de 3 chefs.
● cormillot requiere que todos los platos que saben cocinar los empleados del restaurante sean
saludables y que a ninguna entrada le falte zanahoria.
● gordonRamsay no le da una crítica positiva a ningún restaurante.
*/



criticaPositiva(Critico, Restaurante):-
    Critico /= gordonRamsay,
    critica(Critico, Restaurante),
    inspeccionSatisfactoria(Restaurante).

critica(antonEgo, Restaurante):-
    forall(trabajaEn(Restaurante, _), cocinaBien(_, ratatouille)).

critica(christophe, Restaurante):-
    findall(Empleado, chef(Empleado, Restaurante), Chefs),
    length(Chefs, Cantidad),
    Cantidad > 3.

critica(cormillot, Restaurante):-
    forall((chef(Empleado, Restaurante),cocina(Empleado, Plato, _)), saludable(Plato)),
    forall(plato(Plato, entrada[Ingrediente]), member(zanahoria, Ingrediente)).

