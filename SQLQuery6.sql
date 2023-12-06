USE [firma]
GO

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon VARCHAR (30);

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('+48',telefon);

UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon,1,3) + '-' +
				SUBSTRING(telefon,4,3) + '-' +
				SUBSTRING(telefon,7,3) + '-' +
				SUBSTRING(telefon,10,3);

SELECT TOP 1 * FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;

SELECT imie,nazwisko, HASHBYTES('MD5','pensje') AS Pensja_MD5 FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenia ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje ON pensje.id_pensji = wynagrodzenia.id_pensji;

SELECT imie,nazwisko, pensje.kwota AS Pensja, premie.kwota AS Premia FROM ksiegowosc.wynagrodzenia
LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji = wynagrodzenia.id_pensji
LEFT JOIN ksiegowosc.premie ON premie.id_premii = wynagrodzenia.id_premii
LEFT JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika;

SELECT 'Pracownik' + pracownicy.imie + ' ' + pracownicy.nazwisko + ' w dniu ' + godziny.data + ' otrzyma³ pensjê ca³kowit¹ na kwotê ' + (pensje.kwota + premie.kwota +
ABS(godziny.liczba_godzin - 30)*50) + ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ' + pensje.kwota + ' z³, premia ' + premie.kwota + ' z³, nadgodziny: ' + 
ABS(godziny.liczba_godzin - 30)*50 + ' z³'
FROM ksiegowosc.wynagrodzenia
INNER JOIN ksiegowosc.godziny ON godziny.id_godziny = wynagrodzenia.id_godziny
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN ksiegowosc.premie ON premie.id_premii = wynagrodzenia.id_premii
INNER JOIN ksiegowosc.pensje ON pensje.id_pensji = wynagrodzenia.id_pensji;