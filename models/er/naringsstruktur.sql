with foretak AS (
  SELECT organisasjonsnummer,
  antallansatte AS antall_ansatte,
  naeringskode1_kode AS nace_1
  FROM {{ ref('foretak_situasjonsuttak') }}
),
nace AS (
  SELECT naerk, naerk_tekst FROM {{ ref('wrk_nace') }}
  WHERE length(naerk)=6
),
joined AS (
  SELECT 
  NVL(naerk_tekst, 'Ukjent') AS naering, 
  NVL(naerk, '00.000') AS naeringskode,
  organisasjonsnummer, antall_ansatte FROM foretak
  left join nace ON foretak.nace_1 = nace.naerk
),
nace_count AS (
  SELECT
  naering,
  naeringskode,
  count(organisasjonsnummer) AS antall_foretak,
  sum(antall_ansatte) AS antall_ansatte
  FROM joined
  GROUP BY naering, naeringskode
)
SELECT * FROM nace_count

