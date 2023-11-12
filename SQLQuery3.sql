USE [firma]
GO

CREATE SCHEMA [rozliczenia]
GO

CREATE TABLE rozliczenia.pracownicy(
	id_pracownika INT IDENTITY(1,1) PRIMARY KEY,
	imie VARCHAR (255) NOT NULL,
	nazwisko VARCHAR (255) NOT NULL,
	adres VARCHAR (255),
	telefon VARCHAR (15)
);
CREATE TABLE rozliczenia.godziny(
	id_godziny INT IDENTITY (1,1) PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin INT,
	id_pracownika INT,
);
CREATE TABLE rozliczenia.pensje(
	id_pensji INT IDENTITY (1,1) PRIMARY KEY,
	stanowisko VARCHAR (255) NOT NULL,
	kwota INT NOT NULL,
	id_premii INT,
);
CREATE TABLE rozliczenia.premie(
	id_premii INT IDENTITY (1,1) PRIMARY KEY,
	rodzaj VARCHAR (255) NOT NULL,
	kwota INT NOT NULL,
);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);


INSERT INTO rozliczenia.pracownicy
VALUES
('Jan', 'Kowalski', 'Warszawska 15', 123456789),
('Marek', 'Markowicz', 'Warszawska 22', 234567890),
('Jakub', 'Jakubowicz', 'Warszawska 34', 345678901),
('Jan', 'Janowski', 'Krakowska 32', 456789012),
('Micha³', 'Micha³owicz', 'Krakowska 543', 567890213),
('Marta', 'Martowska', 'Krakowska 432', 678901234),
('Wiktoria', 'Nowak', 'Poznañska 2', 788432923),
('Magdalena', 'Mi³owicz', 'Poznañska 54', 534234645),
('Wiktor', 'Wiktorowicz', 'Szczeciñska 543', 653135896),
('Mariusz', 'Mañkowski', 'Piastowska 432', 126753356);

INSERT INTO rozliczenia.godziny
VALUES
('2023-05-08', 8, 4),
('2023-06-08', 8, 2),
('2023-11-08', 7, 3),
('2023-09-08', 8, 8),
('2023-11-08', 6, 5),
('2023-04-07', 8, 2),
('2023-11-06', 6, 1),
('2023-01-08', 8, 6),
('2023-10-08', 9, 9),
('2023-12-05', 8, 10);

INSERT INTO rozliczenia.pensje
VALUES
('Junior Developer', 1400),
('Senior Developer', 2400),
('Team Leader', 3000),
('UX/UI Specialist', 1500),
('Social Media Manager', 2500),
('Graphic Designer', 1000),
('Ksiêgowy', 2000),
('Sta¿ysta', 1000),
('Recepcjonistka', 1500),
('CEO', 8000);

INSERT INTO rozliczenia.premie
VALUES
('Bo¿e narodzenie', 500),
('Wielkanoc', 200),
('Wakacje', 300),
('Nadgodziny"+"', 400),
('Nadgodziny', 200),
('Ferie zimowe', 150),
('Podnoszenie kwalifikacji', 200),
('Motywacjna', 100),
('Behawioralna', 150),
('Lukratywna', 400);

SELECT 
nazwisko,
adres
FROM
rozliczenia.pracownicy;

SELECT 
DATEPART(dw, data),
DATEPART(mm, data)
FROM
rozliczenia.godziny;

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

ALTER TABLE
rozliczenia.pensje
ADD 
kwota_netto INT NOT NULL;

UPDATE rozliczenia.pensje
SET 
rozliczenia.pensje.kwota_netto = rozliczenia.pensje.kwota_brutto * 0.77;