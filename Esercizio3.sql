/*create a table*/

CREATE TABLE STUDENTE (
    Matricola INT PRIMARY KEY,
    NomeStudente VARCHAR(255),
    Citta VARCHAR(255),
    AnnoLaurea INT,
    TitoloStudio VARCHAR(255),
    VotoLaurea DECIMAL(4, 1)
);

/*insert some values*/

INSERT INTO STUDENTE (Matricola, NomeStudente, Citta, AnnoLaurea, TitoloStudio, VotoLaurea) VALUES 
(1, 'John Doe', 'New York', 2022, 'Bachelor of Science', 80.5),
(2, 'Alice Smith', 'Los Angeles', 2021, 'Bachelor of Arts', 89.2),
(3, 'Bob Johnson', 'Chicago', 2023, 'Bachelor of Engineering', 75.0),
(4, 'Emily Davis', 'San Francisco', 2020, 'Bachelor of Business Administration', 92.3),
(5, 'Michael Wang', 'Houston', 2022, 'Bachelor of Computer Science', 87.5),
(6, 'Sophia Lee', 'Miami', 2021, 'Bachelor of Fine Arts', 78.8),
(7, 'Daniel Garcia', 'Dallas', 2023, 'Bachelor of Medicine', 95.1),
(8, 'Olivia Johnson', 'Seattle', 2020, 'Bachelor of Social Work', 84.6),
(9, 'Ethan Kim', 'Atlanta', 2022, 'Bachelor of Psychology', 100.1),
(10, 'Ava Brown', 'Phoenix', 2021, 'Bachelor of Nursing', 108.2);

/*fetch some values*/

/*SELECT * FROM STUDENTE;*/


/*create a table*/

CREATE TABLE DIPARTIMENTO (
    CodiceDipartimento INT PRIMARY KEY,
    NomeDipartimento VARCHAR(255),
    SettoreScientifico VARCHAR(50),
    NumDocenti INT
);

/*insert some values*/

INSERT INTO DIPARTIMENTO (CodiceDipartimento, NomeDipartimento, SettoreScientifico, NumDocenti) VALUES
(1, 'Computer Science Department', 'Information Technology', 20),
(2, 'Mathematics Department', 'Mathematics', 15),
(3, 'Physics Department', 'Physics', 12),
(4, 'Chemistry Department', 'Chemistry', 18),
(5, 'Biology Department', 'Biology', 25),
(6, 'Engineering Department', 'Mechanical Engineering', 22),
(7, 'Economics Department', 'Economics', 30),
(8, 'Psychology Department', 'Psychology', 10),
(9, 'Languages Department', 'Linguistics', 15),
(10, 'History Department', 'History', 8);

/*fetch some values*/

/*SELECT * FROM DIPARTIMENTO;*/


/*create a table*/

CREATE TABLE CONCORSOMASTER (
    CodiceMaster INT PRIMARY KEY,
    CodiceDipartimento INT,
    DataPubblicazione DATE,
    DataScadenza DATE,
    NumPostiDisponibili INT,
    FOREIGN KEY (CodiceDipartimento) REFERENCES DIPARTIMENTO(CodiceDipartimento)
);

/*insert some values*/

INSERT INTO CONCORSOMASTER (CodiceMaster, CodiceDipartimento, DataPubblicazione, DataScadenza, NumPostiDisponibili) VALUES
(1, 1, '2023-02-15', '2023-02-01', 10),
(2, 2, '2023-02-15', '2023-03-15', 8),
(4, 4, '2023-04-10', '2023-05-10', 12),
(5, 5, '2023-05-20', '2023-06-20', 18),
(6, 6, '2023-06-01', '2023-07-01', 20),
(7, 7, '2023-07-15', '2023-08-15', 25),
(8, 8, '2023-08-30', '2023-09-30', 7),
(9, 9, '2023-08-30', '2023-10-10', 10),
(3, 3, '2023-02-15', '2023-03-15', 6);

/*fetch some values*/

/*SELECT * FROM CONCORSOMASTER;*/


/*insert some values*/

CREATE TABLE PARTECIPACONCORSOMASTER (
    CodiceDipartimento INT,
    CodiceMaster INT,
    MatricolaStudente INT,
    DataInvioDomanda DATE,
    FOREIGN KEY (MatricolaStudente) REFERENCES STUDENTE(Matricola),
    FOREIGN KEY (CodiceDipartimento) REFERENCES DIPARTIMENTO(CodiceDipartimento)
    );

/*insert some values*/

 INSERT INTO PARTECIPACONCORSOMASTER (CodiceDipartimento, CodiceMaster, MatricolaStudente, DataInvioDomanda)
VALUES 
    (2, 1, 10, '2023-01-01'),
    (2, 1, 10, '2023-01-02'),
    (3, 3, 9, '2023-01-03'),
    (5, 4, 5, '2023-01-04'),
    (5, 5, 5, '2023-01-05'),
    (6, 6, 6, '2023-01-06'),
    (5, 7, 5, '2023-01-07'),
    (8, 8, 8, '2023-01-08'),
    (9, 9, 9, '2023-01-09'),
    (10, 10, 10, '2023-01-10');

/*fetch some values*/

/*SELECT * FROM PARTECIPACONCORSOMASTER ;*/

/*   1) Per ogni studente che ha partecipato a 3 concorsi di master,
visualizzare il nome dello studente e il settore scientifico per cui ha partecipato a tutti i concorsi.
Ordinare per Nome dello studente*/

SELECT
    S.NomeStudente,
    D.SettoreScientifico
FROM
    STUDENTE S
JOIN
    PARTECIPACONCORSOMASTER P ON S.Matricola = P.MatricolaStudente
JOIN
    DIPARTIMENTO D ON P.CodiceDipartimento = D.CodiceDipartimento
GROUP BY
    S.Matricola, D.SettoreScientifico
HAVING
    COUNT(DISTINCT P.CodiceMaster) = 3
ORDER BY
    S.NomeStudente;


/* 2) Visualizzare la matricola e il nome degli studenti che hanno conseguito un voto
di laurea superiore a 100 ed hanno partecipato ad almeno due concorsi di master con 
la stessa data di pubblicazione*/

SELECT
    S.Matricola,
    S.NomeStudente
FROM
    STUDENTE S
JOIN
    PARTECIPACONCORSOMASTER P ON S.Matricola = P.MatricolaStudente
JOIN
    CONCORSOMASTER CM ON P.CodiceMaster = CM.CodiceMaster
WHERE
    S.VotoLaurea > 100
GROUP BY
    S.Matricola, S.NomeStudente
HAVING
    COUNT(DISTINCT CM.DataPubblicazione) >= 2;




/*  3) Per i dipartimenti in cui sono stati effettuati solo concorsi di master aventi
ciascuno un numero di posti disponibili superiore a 7, visualizzare il nome del dipartimento,
il settore scientifico di afferenza e il numero di concorsi di master. 
Ordinare per nome del dipartimento e settore scientifico*/

SELECT
    D.NomeDipartimento,
    D.SettoreScientifico,
    COUNT(CM.CodiceMaster) AS NumeroConcorsi
FROM
    DIPARTIMENTO D
JOIN
    CONCORSOMASTER CM ON D.CodiceDipartimento = CM.CodiceDipartimento
WHERE
    CM.NumPostiDisponibili > 7
GROUP BY
    D.CodiceDipartimento, D.NomeDipartimento, D.SettoreScientifico
HAVING
    COUNT(CM.CodiceMaster) = (SELECT COUNT(*) FROM CONCORSOMASTER WHERE CodiceDipartimento = D.CodiceDipartimento)
ORDER BY
    D.NomeDipartimento, D.SettoreScientifico;