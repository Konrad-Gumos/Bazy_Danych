USE [firma]
GO
CREATE SCHEMA [ksiegowosc]
GO

CREATE TABLE ksiegowosc.pracownicy(
	id_pracownika INT IDENTITY(1,1) PRIMARY KEY,
	imie VARCHAR (255) NOT NULL,
	nazwisko VARCHAR (255) NOT NULL,
	adres VARCHAR (255),
	telefon VARCHAR (15),
);

CREATE TABLE ksiegowosc.godziny(
	id_godziny INT IDENTITY(1,1) PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin INT NOT NULL,
	id_pracownika INT NOT NULL FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika),
);

CREATE TABLE ksiegowosc.pensje(
	id_pensji INT IDENTITY (1,1) PRIMARY KEY,
	stanowisko VARCHAR (255) NOT NULL,
	kwota INT NOT NULL,
);
CREATE TABLE ksiegowosc.premie(
	id_premii INT IDENTITY (1,1) PRIMARY KEY,
	rodzaj VARCHAR (255) NOT NULL,
	kwota INT NOT NULL,
);
CREATE TABLE ksiegowosc.wynagrodzenia(
	id_wynagrodzenia INT IDENTITY (1,1) PRIMARY KEY,
	data DATE NOT NULL,
	id_pracownika INT NOT NULL FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika),
	id_godziny INT NOT NULL FOREIGN KEY REFERENCES ksiegowosc.godziny(id_godziny),
	id_pensji INT NOT NULL FOREIGN KEY REFERENCES ksiegowosc.pensje(id_pensji),
	id_premii INT FOREIGN KEY REFERENCES ksiegowosc.premie(id_premii),
);

COMMENT ON TABLE ksiegowosc.pracownicy IS 'dane pracownikow';
COMMENT ON TABLE ksiegowosc.godziny IS 'dane na temat godzin przepracowanych przez pracownikow';
COMMENT ON TABLE ksiegowosc.pensje IS 'informacje na temat kwoty zarabianej na danym stanowisku';
COMMENT ON TABLE ksiegowosc.premie IS 'informacje na temat premii';
COMMENT ON TABLE ksiegowosc.wynagrodzenia IS  'dane o wynagrodzeniu danego pracownika(pensja + wynagrodzenie)';

INSERT INTO ksiegowosc.pracownicy
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

INSERT INTO ksiegowosc.godziny
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

INSERT INTO ksiegowosc.pensje
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

INSERT INTO ksiegowosc.premie
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


INSERT INTO ksiegowosc.wynagrodzenia
VALUES
('2023-10-15', 2, 2, 5, 8),
('2023-10-15', 3, 3, 7, 5),
('2023-10-15', 5, 5, 2, 4),
('2023-09-15', 2, 6, 5, 7),
('2023-09-15', 9, 9, 2, 3),
('2023-08-15', 6, 8, 4, 2),
('2023-08-15', 4, 1, 3, 9),
('2023-06-15', 3, 3, 7, 10),
('2023-06-15', 10, 10, 10, 1),
('2023-06-15', 1, 7, 8, 6);

SELECT
id_pracownika,
nazwisko
FROM
ksiegowosc.pracownicy;

SELECT DISTINCT
id_pracownika
FROM
ksiegowosc.wynagrodzenia
INNER JOIN
ksiegowosc.pensje ON
wynagrodzenia.id_pensji = pensje.id_pensji
INNER JOIN
ksiegowosc.premie ON
wynagrodzenia.id_premii = premie.id_premii
WHERE
(pensje.kwota+premie.kwota)>1000;

SELECT DISTINCT
id_pracownika
FROM
ksiegowosc.wynagrodzenia
INNER JOIN
ksiegowosc.pensje ON
wynagrodzenia.id_pensji = pensje.id_pensji
INNER JOIN
ksiegowosc.premie ON
wynagrodzenia.id_premii = premie.id_premii
WHERE
pensje.kwota>2000;

SELECT
*
FROM 
ksiegowosc.pracownicy
WHERE
imie LIKE 'M%';

SELECT
*
FROM 
ksiegowosc.pracownicy
WHERE
(imie LIKE '%a') AND (nazwisko LIKE '%n%');

SELECT
imie,
nazwisko,
liczba_godzin-8
FROM
ksiegowosc.pracownicy
INNER JOIN 
ksiegowosc.godziny ON
pracownicy.id_pracownika = godziny.id_pracownika
WHERE
liczba_godzin > 8;

SELECT DISTINCT
imie,
nazwisko
FROM
ksiegowosc.pracownicy
INNER JOIN
ksiegowosc.wynagrodzenia ON
pracownicy.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN 
ksiegowosc.pensje ON
wynagrodzenia.id_pensji = pensje.id_pensji
WHERE
pensje.kwota > 1500 AND pensje.kwota < 3000;

SELECT
imie,
nazwisko
FROM
ksiegowosc.pracownicy
INNER JOIN 
ksiegowosc.godziny ON
pracownicy.id_pracownika = godziny.id_pracownika
INNER JOIN
ksiegowosc.wynagrodzenia ON
pracownicy.id_pracownika = wynagrodzenia.id_pracownika
WHERE
liczba_godzin > 8 AND id_premii = NULL;

SELECT 
*
FROM
ksiegowosc.pracownicy
INNER JOIN 
ksiegowosc.wynagrodzenia ON
pracownicy.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN 
ksiegowosc.pensje ON 
wynagrodzenia.id_pensji = pensje.id_pensji
ORDER BY
pensje.kwota;

SELECT 
*
FROM
ksiegowosc.pracownicy
INNER JOIN 
ksiegowosc.wynagrodzenia ON
pracownicy.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN 
ksiegowosc.pensje ON 
wynagrodzenia.id_pensji = pensje.id_pensji
INNER JOIN 
ksiegowosc.premie ON
wynagrodzenia.id_premii = premie.id_premii
ORDER BY
pensje.kwota  + premie.kwota
DESC;

SELECT
pensje.stanowisko,
COUNT(wynagrodzenia.id_pensji) AS ilosc_osob
FROM ksiegowosc.wynagrodzenia
INNER JOIN 
ksiegowosc.pensje ON
wynagrodzenia.id_pensji = pensje.id_pensji
GROUP BY
stanowisko

SELECT 
MIN(pensje.kwota + premie.kwota),
MAX(pensje.kwota + premie.kwota),
AVG(pensje.kwota + premie.kwota)
FROM
ksiegowosc.pensje
INNER JOIN 
ksiegowosc.wynagrodzenia ON
pensje.id_pensji = wynagrodzenia.id_pensji
INNER JOIN
ksiegowosc.premie ON
wynagrodzenia.id_premii = premie.id_premii
WHERE
pensje.stanowisko = 'Ksiêgowy';

SELECT 
SUM(pensje.kwota + premie.kwota)
FROM
ksiegowosc.pensje
INNER JOIN 
ksiegowosc.wynagrodzenia ON
pensje.id_pensji = wynagrodzenia.id_pensji
INNER JOIN
ksiegowosc.premie ON
wynagrodzenia.id_premii = premie.id_premii;

SELECT 
SUM(pensje.kwota + premie.kwota),
pensje.stanowisko
FROM
ksiegowosc.pensje
INNER JOIN 
ksiegowosc.wynagrodzenia ON
pensje.id_pensji = wynagrodzenia.id_pensji
INNER JOIN
ksiegowosc.premie ON
wynagrodzenia.id_premii = premie.id_premii
GROUP BY
pensje.stanowisko;

SELECT
pensje.stanowisko,
COUNT(wynagrodzenia.id_premii)
FROM
ksiegowosc.pensje
INNER JOIN
ksiegowosc.wynagrodzenia ON
pensje.id_pensji = wynagrodzenia.id_pensji
GROUP BY
pensje.stanowisko;

DELETE pracownicy 
FROM 
ksiegowosc.pracownicy
INNER JOIN 
ksiegowosc.wynagrodzenia ON
pracownicy.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN 
ksiegowosc.pensje ON
wynagrodzenia.id_pensji = pensje.id_pensji
WHERE pensje.kwota < 1200;
