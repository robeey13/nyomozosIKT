CREATE DATABASE nyomozas 
DEFAULT CHARACTER SET UTF8 COLLATE utf8_hungarian_ci;

CREATE TABLE csoptagok (
    id INT PRIMARY KEY,
    nev VARCHAR(50) NOT NULL,
    magassag INT,
    hajszin VARCHAR(20),
    szemszin VARCHAR(20),
    eletkor INT,
    arulo boolean
);

CREATE TABLE detektivek (
    id INT PRIMARY KEY,
    nev VARCHAR(50) NOT NULL,
    tapasztalat INT,
    hajszin VARCHAR(20),
    szulev INT
);

CREATE TABLE kikerdezes (
    id int PRIMARY KEY,
    detektiv_id INT NOT NULL,
    csoptag_id INT NOT NULL,
    kerdes VARCHAR(255) NOT NULL,
    valasz VARCHAR(255) NOT NULL,
    FOREIGN KEY (detektiv_id) REFERENCES detektivek(id),
    FOREIGN KEY (csoptag_id) REFERENCES csoptagok(id)
);

INSERT INTO csoptagok (id, nev, magassag, hajszin, szemszin, eletkor, arulo) VALUES
(1, 'Kovács Péter', 175, 'barna', 'kék', 28, FALSE),
(2, 'Nagy Anna', 165, 'szőke', 'zöld', 25, FALSE),
(3, 'Szabó Gábor', 180, 'fekete', 'barna', 32, TRUE),
(4, 'Horváth Mária', 160, 'vörös', 'kék', 29, FALSE),
(5, 'Tóth László', 178, 'ősz', 'szürke', 45, FALSE),
(6, 'Kiss Eszter', 172, 'barna', 'mogyoró', 26, FALSE);

-- Detektívek mintaadatai (AI)
INSERT INTO detektivek (id, nev, tapasztalat, hajszin, szulev) VALUES
(1, 'Varga Zsolt', 15, 'fekete', 1975),
(2, 'Molnár Kata', 8, 'szőke', 1985),
(3, 'Balogh István', 22, 'ősz', 1968),
(4, 'Fekete Judit', 5, 'barna', 1990);

-- Kikérdezések mintaadatai (AI)
INSERT INTO kikerdezes (id, detektiv_id, csoptag_id, kerdes, valasz) VALUES
(1, 1, 1, 'Hol volt május 20-án este 8 órakor?', 'Otthon voltam, gitároztam.'),
(2, 1, 2, 'Látta-e Kovács Pétert május 20-án?', 'Igen, délután találkoztunk a kávézóban.'),
(3, 2, 3, 'Milyen kapcsolatban áll a károsulttal?', 'Régi barátok vagyunk, együtt focizunk.'),
(4, 2, 4, 'Észrevett-e valami gyanúsat az elmúlt napokban?', 'Nem, minden normális volt.'),
(5, 3, 5, 'Mikor látta utoljára a gyanúsítottat?', 'Múlt héten a munkahelyen.'),
(6, 1, 6, 'Van-e alibije a kérdéses időpontra?', 'Igen, táncórán voltam.'),
(7, 4, 1, 'Ismeri-e Kiss Esztert?', 'Igen, együtt dolgozunk projekteken.'),
(8, 4, 3, 'Mit tud a konfliktusról?', 'Hallottam, hogy vitájuk volt a pénz miatt.'),
(9, 2, 5, 'Hajlandó-e együttműködni a nyomozásban?', 'Természetesen, minden segítséget megadok.'),
(10, 3, 2, 'Van-e valamilyen fenyegetése?', 'Nem, biztonságban érzem magam.');


SELECT nev, eletkor, hajszin FROM csoptagok;

SELECT nev, eletkor FROM csoptagok WHERE arulo = TRUE;

SELECT nev, magassag FROM csoptagok WHERE magassag > 175;

SELECT nev, tapasztalat FROM detektivek ORDER BY tapasztalat DESC;

SELECT nev, 'csoporttag' AS tipus FROM csoptagok WHERE hajszin = 'barna'
UNION
SELECT nev, 'detektív' AS tipus FROM detektivek WHERE hajszin = 'barna';

SELECT kikerdezes.valasz
FROM kikerdezes INNER JOIN csoptagok ON kikerdezes.csoptag_id = csoptagok.id
WHERE csoptagok.nev = 'Szabó Gábor' AND kikerdezes.kerdes LIKE '%konfliktus%';

SELECT kikerdezes.valasz
FROM kikerdezes INNER JOIN detektivek ON kikerdezes.detektiv_id = detektivek.id
WHERE detektivek.nev = 'Varga Zsolt';

SELECT kikerdezes.valasz
FROM kikerdezes INNER JOIN csoptagok ON csoptagok.id = kikerdezes.csoptag_id
WHERE csoptagok.id = '1';