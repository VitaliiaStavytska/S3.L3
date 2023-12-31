/*create a table*/
CREATE TABLE STUDENTE (
    Matricola INT PRIMARY KEY,
    Nome VARCHAR(255),
    Citta VARCHAR(255)
);
/*insert some values*/

INSERT INTO STUDENTE (Matricola, Nome, Citta) VALUES 
(1, 'John Doe', 'New York'),
(2, 'Alice Smith', 'Los Angeles'),
(3, 'Bob Johnson', 'Chicago'),
(4, 'Emily Davis', 'San Francisco'),
(5, 'Michael Wang', 'Houston'),
(6, 'Sophia Lee', 'Miami'),
(7, 'Daniel Garcia', 'Dallas'),
(8, 'Olivia Johnson', 'Seattle'),
(9, 'Ethan Kim', 'Atlanta'),
(10, 'Ava Brown', 'Phoenix');

/*fetch some values*/

/*SELECT * FROM STUDENTE;*/


/*create a table*/

CREATE TABLE CORSO (
    Codice INT PRIMARY KEY,
    Nome VARCHAR(255),
    MatricolaDocente INT
);

/*--insert some values*/

INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (1, 'Introduction to SQL', 12345);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (2, 'Advanced Database Management', 67890);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (3, 'Data Modeling Basics', 54321);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (4, 'Query Optimization Techniques', 98765);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (5, 'Database Security Fundamentals', 11111);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (6, 'NoSQL Databases Overview', 22222);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (7, 'Introduction to Big Data', 33333);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (8, 'Web Development with Databases', 44444);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (9, 'Data Warehousing Concepts', 55555);
INSERT INTO CORSO (Codice, Nome, MatricolaDocente) VALUES (10, 'Cloud Database Services', 66666);

/*-- fetch some values*/

/*SELECT * FROM CORSO;*/

/*-- create a table*/

CREATE TABLE DOCENTE (
    Matricola INT PRIMARY KEY,
    Nome VARCHAR(255)
);

/*--insert some values*/

INSERT INTO DOCENTE (Matricola, Nome) VALUES (12345, 'Mario Rossi');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (67890, 'Luca Bianchi');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (54321, 'Anna Verdi');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (98765, 'Giuseppe Neri');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (11111, 'Laura Giallo');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (22222, 'Roberto Azzurro');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (33333, 'Elena Marrone');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (44444, 'Giovanni Viola');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (55555, 'Francesca Rosa');
INSERT INTO DOCENTE (Matricola, Nome) VALUES (66666, 'Paolo Nero');

/*-- fetch some values*/

/*SELECT * FROM DOCENTE;*/

/*-- create a table*/

CREATE TABLE ESAME (
    Codice INT PRIMARY KEY,
    MatricolaStudente INT,
    Data DATE,
    Voto DECIMAL(3, 1),
    SettoreScientifico VARCHAR(50),
    FOREIGN KEY (MatricolaStudente) REFERENCES STUDENTE(Matricola)
);

/*--insert some values*/

INSERT INTO ESAME (Codice, MatricolaStudente, Data, Voto, SettoreScientifico) VALUES 
(1, 1, '2023-01-15', 45.5, 'Computer Science'),
(2, 1, '2023-02-20', 92.0, 'Information Technology'),
(3, 3, '2023-03-10', 78.5, 'Data Science'),
(4, 4, '2023-04-05', 15.0, 'Database Management'),
(5, 5, '2023-05-12', 88.5, 'Software Engineering'),
(6, 6, '2023-06-18', 27.0, 'Web Development'),
(7, 7, '2023-07-25', 79.5, 'Computer Networks'),
(8, 8, '2023-08-30', 94.5, 'Artificial Intelligence'),
(9, 9, '2023-09-14', 87.0, 'Cybersecurity'),
(10, 10, '2023-10-22', 37.5, 'Cloud Computing');

/*fetch some values*/

/*SELECT * FROM ESAME;*/

/*  1)Per ogni studente, visualizzare gli esami sostenuti con voto maggiore di 28
assieme alla matricola dello studente e al nome del docente che ha tenuto il corso.*/

 SELECT
    S.Matricola AS MatricolaStudente,
    S.Nome AS NomeStudente,
    E.Codice AS CodiceEsame,
    E.Voto AS EsameVoto,
    D.Nome AS NomeDocente
FROM
    STUDENTE S
JOIN
    ESAME E ON S.Matricola = E.MatricolaStudente
JOIN
    CORSO C ON E.Codice = C.Codice
JOIN
    DOCENTE D ON C.MatricolaDocente = D.Matricola
WHERE
    E.Voto > 28;


/*  2)Per ogni docente, visualizzare il nome, il nome del corso di cui è titolare e il settore scientifico del corso.*/

SELECT
    D.Nome AS NomeDocente,
    C.Nome AS NomeCorso,
    E.SettoreScientifico AS SettoreScientifico
FROM
    DOCENTE D
JOIN
    CORSO C ON D.Matricola = C.MatricolaDocente
JOIN 
    ESAME E ON C.Codice = E.Codice;


/* 3) Visualizzare per ogni studente la matricola, il nome, il voto massimo, minimo e medio conseguito negli esami. */

SELECT
    S.Matricola AS MatricolaStudente,
    S.Nome AS NomeStudente,
    MAX(E.Voto) AS VotoMassimo,
    MIN(E.Voto) AS VotoMinimo,
    AVG(E.Voto) AS VotoMedio
FROM
    STUDENTE S
JOIN
    ESAME E ON S.Matricola = E.MatricolaStudente
GROUP BY
    S.Matricola, S.Nome;

/* Visualizzare - per ogni studente con media voti maggiore di 25 e che ha sostenuto esami in almeno 10 date
- la matricola, il nome, il voto massimo, minimo e medio conseguito negli esami. Ordinare per voto.*/

SELECT
    S.Matricola AS MatricolaStudente,
    S.Nome AS NomeStudente,
    MAX(E.Voto) AS VotoMassimo,
    MIN(E.Voto) AS VotoMinimo,
    AVG(E.Voto) AS VotoMedio
FROM
    STUDENTE S
JOIN
    ESAME E ON S.Matricola = E.MatricolaStudente
GROUP BY
    S.Matricola, S.Nome
HAVING
    COUNT(DISTINCT E.Data) >= 2 AND AVG(E.Voto) > 25
ORDER BY
    VotoMedio DESC;




