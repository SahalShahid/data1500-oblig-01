
-- SQL-SPØRRINGER FOR OBLIG 1, DEL 5
-- ============================================================================


-- OPPGAVE 5.1: Vis alle sykler
-- ============================================================================
SELECT * FROM sykkel;

-- ============================================================================
-- OPPGAVE 5.2: Vis etternavn, fornavn og mobilnummer for alle kunder, sortert på etternavn
-- ============================================================================
SELECT etternavn, fornavn, mobilnummer
FROM kunde
ORDER BY etternavn;

-- ============================================================================
-- OPPGAVE 5.3: Vis alle sykler som er tatt i bruk etter 1. april 2023
-- ============================================================================
SELECT *
FROM sykkel
WHERE tatt_i_bruk_dato > '2023-04-01';

-- ============================================================================
-- OPPGAVE 5.4: Vis antall kunder i bysykkelordningen
-- ============================================================================
SELECT COUNT(*) AS antall_kunder
FROM kunde;

-- ============================================================================
-- OPPGAVE 5.5: Vis alle kunder og antall utleieforhold for hver kunde
-- ============================================================================
SELECT k.kunde_id, k.fornavn, k.etternavn, COUNT(u.utleie_id) AS antall_utleie
FROM kunde k
LEFT JOIN utleie u ON k.kunde_id = u.kunde_id
GROUP BY k.kunde_id, k.fornavn, k.etternavn
ORDER BY k.etternavn;

-- ============================================================================
-- OPPGAVE 5.6: Vis kunder som aldri har leid en sykkel
-- ============================================================================
SELECT k.kunde_id, k.fornavn, k.etternavn
FROM kunde k
LEFT JOIN utleie u ON k.kunde_id = u.kunde_id
WHERE u.utleie_id IS NULL
ORDER BY k.etternavn;

-- ============================================================================
-- OPPGAVE 5.7: Vis sykler som aldri har vært utleid
-- ============================================================================
SELECT s.sykkel_id, s.type, s.modell
FROM sykkel s
LEFT JOIN utleie u ON s.sykkel_id = u.sykkel_id
WHERE u.utleie_id IS NULL;

-- ============================================================================
-- OPPGAVE 5.8: Vis sykler med kundeinfo som ikke er levert tilbake etter ett døgn
-- ============================================================================
SELECT s.sykkel_id, s.type, s.modell, k.kunde_id, k.fornavn, k.etternavn, u.utleie_dato
FROM utleie u
JOIN sykkel s ON u.sykkel_id = s.sykkel_id
JOIN kunde k ON u.kunde_id = k.kunde_id
WHERE u.tilbakelevert_dato IS NULL
  AND u.utleie_dato < NOW() - INTERVAL '1 day';
