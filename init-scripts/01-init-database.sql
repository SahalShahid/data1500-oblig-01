-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett tabeller

CREATE TABLE Kunde (
    kunde_id SERIAL PRIMARY KEY,
    fornavn VARCHAR(50) NOT NULL,
    etternavn VARCHAR(50) NOT NULL,
    mobilnummer VARCHAR(15) NOT NULL CHECK (mobilnummer ~ '^[0-9+]+$'),
    epost VARCHAR(100) NOT NULL CHECK (epost LIKE '%@%.%'),
    betalingsreferanse VARCHAR(100)
);

CREATE TABLE Sykkelstasjon (
    stasjon_id SERIAL PRIMARY KEY,
    navn VARCHAR(100) NOT NULL,
    adresse VARCHAR(150),
    kapasitet INT NOT NULL CHECK (kapasitet > 0)
);

CREATE TABLE Laas (
    laas_id SERIAL PRIMARY KEY,
    stasjon_id INT NOT NULL REFERENCES Sykkelstasjon(stasjon_id),
    status VARCHAR(20) NOT NULL CHECK (status IN ('ledig','opptatt','defekt'))
);

CREATE TABLE Sykkel (
    sykkel_id SERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL CHECK (status IN ('tilgjengelig','utleid','ute_av_drift')),
    stasjon_id INT REFERENCES Sykkelstasjon(stasjon_id)
);

CREATE TABLE Utleie (
    utleie_id SERIAL PRIMARY KEY,
    kunde_id INT NOT NULL REFERENCES Kunde(kunde_id),
    sykkel_id INT NOT NULL REFERENCES Sykkel(sykkel_id),
    utlevert_tidspunkt TIMESTAMP NOT NULL,
    innlevert_tidspunkt TIMESTAMP,
    leiebelop DECIMAL(8,2) NOT NULL CHECK (leiebelop >= 0),
    CHECK (innlevert_tidspunkt IS NULL OR innlevert_tidspunkt >= utlevert_tidspunkt)
);

-- Sett inn testdata

INSERT INTO Kunde (fornavn, etternavn, mobilnummer, epost, betalingsreferanse) VALUES
('Ola','Nordmann','+4712345678','ola@norge.no','token1'),
('Kari','Hansen','+4798765432','kari@norge.no','token2'),
('Per','Johansen','+4711223344','per@norge.no','token3'),
('Anne','Larsen','+4799887766','anne@norge.no','token4'),
('Lars','Olsen','+4711334455','lars@norge.no','token5');

INSERT INTO Sykkelstasjon (navn, adresse, kapasitet) VALUES
('Sentrum','Sentrumsgate 1',20),
('St. Hanshaugen','St. Hanshaugen 5',20),
('Majorstuen','Majorstuveien 10',20),
('Grünerløkka','Thorvald Meyers gate 30',20),
('Tøyen','Tøyen Torg 5',20);

-- 100 låser (20 per stasjon)
INSERT INTO Laas (stasjon_id, status)
SELECT s.stasjon_id, 'ledig'
FROM Sykkelstasjon s, generate_series(1,20);

-- 100 sykler
INSERT INTO Sykkel (status, stasjon_id)
SELECT 
    CASE WHEN gs % 5 = 0 THEN 'utleid' ELSE 'tilgjengelig' END,
    CASE WHEN gs % 5 = 0 THEN NULL ELSE (gs % 5) + 1 END
FROM generate_series(1,100) gs;

-- 50 utleier
INSERT INTO Utleie (kunde_id, sykkel_id, utlevert_tidspunkt, innlevert_tidspunkt, leiebelop)
SELECT 
    ((gs - 1) % 5) + 1,
    gs,
    NOW() - (interval '1 day' * (gs % 10)),
    NOW() - (interval '1 day' * ((gs % 10)-1)),
    ROUND((5 + random()*15)::numeric,2)
FROM generate_series(1,50) gs;

-- DBA setninger (rolle og bruker)
CREATE ROLE kunde;
CREATE USER kunde_1 WITH PASSWORD 'SterktPassord123';

GRANT SELECT ON Kunde TO kunde;
GRANT SELECT ON Utleie TO kunde;
GRANT kunde TO kunde_1;

-- Eventuelt: indekser
CREATE INDEX idx_utleie_sykkel_id ON Utleie(sykkel_id);

-- Bekreftelse
SELECT 'Database initialisert!' as status;
