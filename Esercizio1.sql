/* create a new table*/

CREATE TABLE DISCO (
  NroSerie VARCHAR(50) PRIMARY KEY,
  TitoloAlbum VARCHAR(100),
  Artista VARCHAR(100),
  Anno INT,
  Prezzo DECIMAL(10, 2)
);

/*insert some values*/

INSERT INTO DISCO VALUES ('ITA001', 'La Voce del Padrone', 'Artista1',NULL, 12.99);
INSERT INTO DISCO VALUES ('ITA002', 'Il cielo in una stanza', 'Artista2', 1960, 15.50);
INSERT INTO DISCO VALUES ('ITA003', 'Nessuno mi può giudicare', 'Divino', 1966, 18.95);
INSERT INTO DISCO VALUES ('ITA004', 'Volare', 'Artista4', NULL, 14.99);
INSERT INTO DISCO VALUES ('ITA005', 'Concerto Grosso n. 1', 'Artista5',NULL, 22.50);
INSERT INTO DISCO VALUES ('ITA006', 'Aida', 'Artista6', 1871, 19.99);
INSERT INTO DISCO VALUES ('ITA007', 'L Isola che non c era', 'De Rossi', 1983, 17.75);
INSERT INTO DISCO VALUES ('ITA008', 'Le Orme', 'Artista8', 1975, 20.25);
INSERT INTO DISCO VALUES ('ITA009', 'Il Fantasma dell\'Opera', 'Artista9', 1990, 24.43);
INSERT INTO DISCO VALUES ('ITA010', 'Titolo 10', 'Artista10',NULL, 30.00);

/* fetch some inform
    
SELECT * FROM DISCO;*/


 /* create a new table*/ 
    
CREATE TABLE ESECUZIONE (
  CodiceReg INT PRIMARY KEY,
  TitoloCanz VARCHAR(100),
  Anno INT
);
ALTER TABLE ESECUZIONE
ADD INDEX idx_CodiceReg (CodiceReg);

/* insert some values*/
 
INSERT INTO ESECUZIONE (CodiceReg, TitoloCanz, Anno) VALUES
(11, 'Volare', NULL),
(12, 'Le Orme', 1975),
(13, 'Aida', NULL),
(14, 'Canzone 1', 2020),
(25, 'Canzone 2', 2019),
(15, 'Canzone 3', 2021),
(4, 'Canzone 4', 2018),
(45, 'Canzone 5', 2022),
(56, 'Canzone 6', 2017),
(87, 'Canzone 7', NULL),
(98, 'Canzone 8', 2016),
(20, 'Canzone 9', 2024),
(10, 'Canzone 10', 2015);

/*fetch some inform
SELECT * FROM ESECUZIONE;
 */

    
/*Create e table CONTIENE*/
    
CREATE TABLE CONTIENE (
  NroSerieDisco VARCHAR(50),
  CodiceReg INT,
  NroProg INT,
  PRIMARY KEY (NroSerieDisco)
);
    
/*Inserisci alcuni valori*/
    
INSERT INTO CONTIENE (NroSerieDisco, CodiceReg, NroProg) VALUES
('ITA001', 11, 1),
('ITA002', 12, 2),
('ITA003', 13, 3),
('ITA004', 14, 4),
('ITA005', 15, 5),
('ITA006', 16, 6),
('ITA007', 17, 7),
('ITA008', 18, 8),
('ITA009', 19, 9),
('ITA010', 20, 10);

/*Visualizza i dati
    
SELECT * FROM CONTIENE;
*/

    
/*Create a new table*/ 
    
CREATE TABLE AUTORE (
  Nome VARCHAR(100),
  TitoloCanzone VARCHAR(100),
  PRIMARY KEY (TitoloCanzone)
);
    
/*Insert some values*/
    
INSERT INTO AUTORE (Nome, TitoloCanzone) VALUES
('Cantante1', 'Canzone1'),
('Autore2', 'Canzone2'),
('Divino', 'Canzone3'),
('Autore4', 'Canzone4'),
('Autore5', 'Canzone5'),
('De Rossi', 'Canzone6'),
('Autore7', 'Canzone7'),
('Autore8', 'Canzone8'),
('Autore9', 'Canzone9'),
('Autore10', 'Canzone10');

/*Fetch some information
    
SELECT * FROM AUTORE;
*/

    
/*-- Create a table CANTANTE*/

CREATE TABLE CANTANTE (
  NomeCantante VARCHAR(100),
  CodiceReg INT
); 
   
/*Inserire alcuni valori*/

INSERT INTO CANTANTE (NomeCantante, CodiceReg) VALUES
('Cantante1', 11),
('Cantante2', 12),
('Cantante3', 13),
('De Rossi', 14),
('Cantante5', 15),
('Cantante6', 16),
('Divino', 17),
('Cantante8', 18),
('Cantante9', 19),
('Cantante10', 20);

/*Fetch some information

SELECT * FROM CANTANTE;
*/


/*1)I cantautori (persone che hanno cantato e scritto la stessa canzone) il cui nome inizia per 'D’;*/
    
SELECT C.NomeCantante, A.TitoloCanzone
FROM CANTANTE C
JOIN AUTORE A ON C.NomeCantante = A.Nome
WHERE C.NomeCantante LIKE 'D%'; 

/*2)I titoli dei dischi che contengono canzoni di cui non si conosce l'anno di registrazione;*/

SELECT TitoloAlbum FROM DISCO D
JOIN CONTIENE C
ON C.NroSerieDisco = D.NroSerie
JOIN ESECUZIONE E
ON E.CodiceReg = C.CodiceReg
WHERE E.Anno IS NULL;

/* 3)I cantanti che hanno sempre registrato canzoni come solisti.*/

SELECT B.NomeCantante AS NomeCantante
FROM CANTANTE B
WHERE NOT EXISTS (
    SELECT *
    FROM CANTANTE C
    WHERE C.CodiceReg <> B.CodiceReg
      AND C.NomeCantante <> B.NomeCantante
);