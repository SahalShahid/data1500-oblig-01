# Besvarelse - Refleksjon og Analyse

**Student:** Mohammad Sahal Shahid

**Studentnummer:** [Ditt studentnummer]

**Dato:** [Innleveringsdato]

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

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 1NF og hvorfor]

**Vurdering av 2. normalform (2NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 2NF og hvorfor]

**Vurdering av 3. normalform (3NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 3NF og hvorfor]

**Eventuelle justeringer:**

[Skriv ditt svar her - hvis modellen ikke var på 3NF, forklar hvilke justeringer du har gjort]

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: [antall]
- Sykler: [antall]
- Sykkelstasjoner: [antall]
- Låser: [antall]
- Utleier: [antall]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]

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
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[Skriv din utregning her]

**Estimat for lagringskapasitet:**

[Skriv din utregning her - vis hvordan du har beregnet lagringskapasiteten for hver tabell]

**Totalt for første år:**

[Skriv ditt estimat her]

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[Skriv ditt svar her - gi konkrete eksempler fra CSV-filen som viser redundans]

**Problem 2: Inkonsistens**

[Skriv ditt svar her - forklar hvordan redundans kan føre til inkonsistens med eksempler]

**Problem 3: Oppdateringsanomalier**

[Skriv ditt svar her - diskuter slette-, innsettings- og oppdateringsanomalier]

**Fordeler med en indeks:**

[Skriv ditt svar her - forklar hvorfor en indeks ville gjort spørringen mer effektiv]

**Case 1: Indeks passer i RAM**

[Skriv ditt svar her - forklar hvordan indeksen fungerer når den passer i minnet]

**Case 2: Indeks passer ikke i RAM**

[Skriv ditt svar her - forklar hvordan flettesortering kan brukes]

**Datastrukturer i DBMS:**

[Skriv ditt svar her - diskuter B+-tre og hash-indekser]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[Skriv ditt svar her - f.eks. heap-fil, LSM-tree, eller annen egnet datastruktur]

**Begrunnelse:**

**Skrive-operasjoner:**

[Skriv ditt svar her - forklar hvorfor datastrukturen er egnet for mange skrive-operasjoner]

**Lese-operasjoner:**

[Skriv ditt svar her - forklar hvordan datastrukturen håndterer sjeldne lese-operasjoner]

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[Skriv ditt svar her - argumenter for validering i ett eller flere lag]

**Validering i nettleseren:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i applikasjonslaget:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i databasen:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Konklusjon:**

[Skriv ditt svar her - oppsummer hvor validering bør gjøres og hvorfor]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[Skriv din refleksjon her - diskuter sentrale konsepter du har lært]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[Skriv din refleksjon her - diskuter hvilke deler av oppgaven som var mest krevende]

**Hva har du lært om databasedesign:**

[Skriv din refleksjon her - reflekter over prosessen med å designe en database fra bunnen av]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


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
