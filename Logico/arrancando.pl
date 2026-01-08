
% Materias
materia(paradigmas, 2).
materia(sintaxis, 2).
materia(analisis2, 2).
materia(analisis1, 1).

% Profesores (corregido variables singleton)
profesor(fede, paradigmas, _).
profesor(fede, desarrolloSW, _).
profesor(bruno, sintaxis, _).
profesor(lautaro, _, _).  % Agregado para que funcione esFacil/1

% Reglas para esFacil
esFacil(NombreMateria) :- 
    materia(NombreMateria, Anio),
    Anio < 3.  % Cambiado de > a < para que tenga sentido

esFacil(NombreMateria) :-
    profesor(lautaro, NombreMateria, _).

esFacil(ingenieriaYSociedad).

% Reglas para profeDe
profeDe(Profe, Anio) :-
    profesor(Profe, Materia, _),
    materia(Materia, Anio).

% Correlativas
correlativa(paradigmas, discreta).
correlativa(paradigmas, algoritmos).
correlativa(analisis2, analisis1).
correlativa(desarrolloSW, paradigmas).

% Reglas para sonCorrelativas
sonCorrelativas(Materia1, Materia2) :-
    correlativa(Materia1, Materia2).

sonCorrelativas(Materia1, Materia2) :-
    correlativa(Materia1, MateriaEnElMedio),
    sonCorrelativas(MateriaEnElMedio, Materia2).

% Reglas para expertoEnElTema
expertoEnElTema(NombreProfesor) :-
    profesor(NombreProfesor, Materia1, _),
    profesor(NombreProfesor, Materia2, _),
    sonCorrelativas(Materia1, Materia2).

% Reglas para masDeUnCursoDe
masDeUnCursoDe(Profe, Materia) :-
    profesor(Profe, Materia, Curso1),
    profesor(Profe, Materia, Curso2),
    Curso1 \= Curso2.

legajo(fede, 1231662).
legajo(ale, 1595465).
legajo(joaco, 2026399).
legajo(mili, 2140998).
legajo(francisco, 2223326).

cursada(fede, k2126, 6, 6).
cursada(ale, k2003, 6, 6).
cursada(joaco, k2003, 10, 6).
cursada(fede, k2026, 2, 4).
cursada(fede, k2026, 8, 8).

curso(k2126, sintaxis, 2007).
curso(k2126, sintaxis, 2010).
curso(k2026, paradigmas, 2010).
curso(k2003, paradigmas, 2017).
curso(k2003, paradigmas, 2021).


% Regla para promedio/3 (corregido espacio)
promedio(Alumno, Materia, Promedio) :-
    cursada(Alumno, CodigoCurso, Nota1, Nota2),
    curso(CodigoCurso, Materia, _),
    Promedio is (Nota1 + Nota2) / 2.

% Regla para aprobo/2
aprobo(Alumno, Materia) :-
    promediaMasDe(Alumno, Materia, 6).

% Regla para promociona/2
promociona(Alumno, Materia) :-
    promediaMasDe(Alumno, Materia, 8).

promediaMasDe(Alumno, Materia, NotaMinima) :-
    promedio(Alumno, Materia, Promedio),
    Promedio >= NotaMinima.

recursa(Alumno, Materia) :-
    haCursado(Alumno,Materia),
    not(aprueba(Alumno, Materia)).


haCursado(Alumno, Materia) :-
    cursada(Alumno, Codigo, _, _),
    curso(Codigo, Materia, _).

ingresante(Alumno) :-
    legajo(Alumno, _),
    not(haCursado(Alumno, _)).