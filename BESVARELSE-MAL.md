# Besvarelse - Refleksjon og Analyse

**Student:** Mohammad Sahal Shahid

**Studentnummer:** 407505

**Dato:** 01.03.26

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**
Kunde,
Sykkel,
Sykkelstasjon,
Lås,
Utleie,

**Attributter for hver entitet:**
**Kunde**
kunde_id (Primærnøkkel),
fornavn,
etternavn,
mobilnummer,
epost,
betalingsreferanse

**Sykkel**
sykkel_id (Primærnøkkel),
status (tilgjengelig, utleid, ute_av_drift),
stasjon_id (Fremmednøkkel, kan være NULL når sykkelen er utleid)

**Sykkelstasjon**
stasjon_id (Primærnøkkel),
navn,
adresse,
kapasitet,

**Lås**
lås_id (Primærnøkkel),
stasjon_id (Fremmednøkkel),
status (ledig, opptatt, defekt),

**Utleie**
utleie_id (Primærnøkkel),
kunde_id (Fremmednøkkel),
sykkel_id (Fremmednøkkel),
utlevert_tidspunkt,
innlevert_tidspunkt (kan være NULL frem til levering),
leiebeløp



---

### Oppgave 1.2: Datatyper og `CHECK`-constraints


**Valgte datatyper og begrunnelser:**

**Kunde:**
kunde_id → INT (PRIMARY KEY, SERIAL)
fornavn → VARCHAR(50)
etternavn → VARCHAR(50)
mobilnummer → VARCHAR(15)
epost → VARCHAR(100)
betalingsreferanse → VARCHAR(100)

**Sykkel:**
sykkel_id → INT (PRIMARY KEY),
status → VARCHAR(20),
stasjon_id → INT (FOREIGN KEY, NULL tillatt),

**Sykkelstasjon:**
stasjon_id → INT (PRIMARY KEY)
navn → VARCHAR(100)
adresse → VARCHAR(150)
kapasitet → INT

**Lås:**
lås_id → INT (PRIMARY KEY)
stasjon_id → INT (FOREIGN KEY)
status → VARCHAR(20)

**Utleie:**
utleie_id → INT (PRIMARY KEY),
kunde_id → INT (FOREIGN KEY),
sykkel_id → INT (FOREIGN KEY),
utlevert_tidspunkt → TIMESTAMP,
innlevert_tidspunkt → TIMESTAMP (NULL tillatt),
leiebeløp → DECIMAL(8,2)

**`CHECK`-constraints:**

Sykkel.status → CHECK (status IN ('tilgjengelig','utleid','ute_av_drift'))

Lås.status → CHECK (status IN ('ledig','opptatt','defekt'))

Sykkelstasjon.kapasitet → CHECK (kapasitet > 0)

Utleie.leiebeløp → CHECK (leiebelop >= 0)

Utleie.innlevert_tidspunkt → CHECK (innlevert_tidspunkt IS NULL OR innlevert_tidspunkt >= utlevert_tidspunkt)

Kunde.epost → CHECK (epost LIKE '%@%.%')

Kunde.mobilnummer → CHECK (mobilnummer ~ '^[0-9+]+$')

**ER-diagram:**
KUNDE ||--o{ UTLEIE : har
SYKKEL ||--o{ UTLEIE : brukes_i
STASJON ||--o{ LAAS : har
STASJON ||--o{ SYKKEL : inneholder

KUNDE {
    int kunde_id PK
    varchar fornavn
    varchar etternavn
    varchar mobil
    varchar epost
}

SYKKEL {
    int sykkel_id PK
    date registrert_dato
    int stasjon_id FK
    int laas_id FK
}

STASJON {
    int stasjon_id PK
    varchar navn
    varchar adresse
}

LAAS {
    int laas_id PK
    int stasjon_id FK
}

UTLEIE {
    int utleie_id PK
    int kunde_id FK
    int sykkel_id FK
    timestamp utlevert
    timestamp innlevert
    numeric beloep
} 
[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**

Alle entiteter har enkelt primærnøkkel: kunde_id, sykkel_id, stasjon_id, lås_id, utleie_id.
Enkelt, effektivt og sikrer entydig identifikasjon.

**Naturlige vs. surrogatnøkler:**

Bruker surrogatnøkler (SERIAL) for alle tabeller.
Fordel: Unik identifikator uavhengig av attributtverdier.

**Oppdatert ER-diagram:**

Skjønte ikke
---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

Kunde – Utleie: 1:M
Sykkel – Utleie: 1:M
Sykkelstasjon – Sykkel: 1:M
Sykkelstasjon – Lås: 1:M

**Fremmednøkler:**

Utleie.kunde_id → Kunde(kunde_id)
Utleie.sykkel_id → Sykkel(sykkel_id)
Sykkel.stasjon_id → Sykkelstasjon(stasjon_id), NULL når utleid
Lås.stasjon_id → Sykkelstasjon(stasjon_id

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**

Alle attributter atomære, alle tabeller har primærnøkkel → tilfredsstiller 1NF.

**Vurdering av 2. normalform (2NF):**

Alle tabeller har enkel primærnøkkel, ingen delvise avhengigheter → tilfredsstiller 2NF.


**Vurdering av 3. normalform (3NF):**

Ingen transitive avhengigheter, alle ikke-nøkkelattributter direkte avhengige av primærnøkkel → tilfredsstiller 3NF.

**Eventuelle justeringer:**

Ingen nødvendig, modellen er allerede på 3NF.

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`] NB! skjønte ikke

**Antall testdata:**

- Kunder: 5
- Sykler: 100
- Sykkelstasjoner: 5
- Låser: 100
- Utleier: 50

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

NOTICE: CREATE TABLE / PRIMARY KEY / FOREIGN KEY constraints applied
INSERT 0 5
INSERT 0 5
INSERT 0 100
INSERT 0 100
INSERT 0 50

**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**

```
kunde
laas
sykkel
sykkelstasjon
utleie
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
CREATE ROLE kunde;
```

**SQL for å opprette bruker:**

```sql
CREATE USER kunde_1 WITH PASSWORD 'SterktPassord123';
```

**SQL for å tildele rettigheter:**

```sql
GRANT SELECT ON Kunde TO kunde;
GRANT SELECT ON Utleie TO kunde;
GRANT kunde TO kunde_1;
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
CREATE OR REPLACE VIEW MineUtleier AS
SELECT u.*
FROM Utleie u
JOIN Kunde k ON u.kunde_id = k.kunde_id
WHERE k.mobilnummer = current_user;
```

**Ulempe med VIEW vs. POLICIES:**

VIEW begrenser kun synlighet, men beskytter ikke tabellen under.
POLICIES håndhever sikkerhet på radnivå direkte, derfor sikrere.

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

Høysesong: 5 × 20 000 = 100 000
Mellomsesong: 4 × 5 000 = 20 000
Lavsesong: 3 × 500 = 1 500
Totalt = 121 500

**Estimat for lagringskapasitet:**

Kunde: 5 × ~200 B ≈ 1 KB
Sykkelstasjon: 5 × ~150 B ≈ 1 KB
Låser: 100 × ~50 B ≈ 5 KB
Sykkel: 100 × ~100 B ≈ 10 KB
Utleie: 121 500 × ~150 B ≈ 18 MB

**Totalt for første år:**

18–20 MB

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

Kundedata og sykkeldata gjentas for hver utleie i CSV.

**Problem 2: Inkonsistens**

Endring i kundens epost krever oppdatering i alle utleierader.

**Problem 3: Oppdateringsanomalier**

Sletting av utleie kan utilsiktet fjerne kundedata.
Innsetting krever duplikater av kundedata.
Oppdatering av sykkeldata må gjøres i alle rader.

**Fordeler med en indeks:**

Rask tilgang til alle utleier for en gitt sykkel.

**Case 1: Indeks passer i RAM**

direkte oppslag i minnet.

**Case 2: Indeks passer ikke i RAM**

flettesortering på disk (B+-tre).

**Datastrukturer i DBMS:**

B+-tre: effektiv for søk og intervallspørringer.
Hash-indekser: effektiv for eksakt oppslag.

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

LSM-tree

**Begrunnelse:**

**Skrive-operasjoner:**

Sekvensielt lagret, optimalisert for mange innsettinger.

**Lese-operasjoner:**

Kombinerer flere nivåer for effektiv søking, caching mulig.

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

Flere lag for sikkerhet og UX.

**Validering i nettleseren:**

Fordel: Rask tilbakemelding
Ulempe: Kan omgås

**Validering i applikasjonslaget:**

Fordel: Kontrollert miljø, logikk og feilmeldinger
Ulempe: Mer kode å vedlikeholde

**Validering i databasen:**

Fordel: Sikrer integritet uansett klient
Ulempe: Mindre fleksibelt

**Konklusjon:**

Kombinasjon av alle tre lag anbefales.

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

Relasjonsdatabaser, ER-diagrammer, normalisering, SQL, tilgangskontroll, indekser.
Effektiv datamodellering, integritet og sikkerhet.

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

Praktisk erfaring med design, SQL, tilgangskontroll og refleksjon.

**Hva var mest utfordrende:**

Normalisering, balanse mellom sikkerhet og effektivitet, lagringsberegninger.

**Hva har du lært om databasedesign:**

Planlegging av entiteter, forhold og nøkkelbegrensninger.
Riktig strukturering reduserer redundans og anomalier.
Tilgangskontroll og policies forbedrer sikkerhet og integritet.

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`] NB! Skjønte ikke


**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]

---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**
