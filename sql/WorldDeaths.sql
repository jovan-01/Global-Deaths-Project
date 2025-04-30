Select * 
From deaths;

-- Alter table deaths Add Column `Date` Date;
-- Update deaths
-- Set `Date` = str_to_date(concat(`Year`, '-01-01'), '%Y-%m-%d');

-- Alter table deaths Drop Column `Year`;

#Communicable (Infectious) Diseases
Select Entity,`Date`, Meningitis, Malaria, `HIV/AIDS`, Tuberculosis, 
`Lower respiratory infections`, `Diarrheal diseases`, `Acute hepatitis`
From deaths;


#Behavioral & Substance‑Use Disorders
Select Entity,`Date`,`Drug use disorders`,`Alcohol use disorders`, `Self-harm` 
From deaths;

#Chronic Non‑Communicable Diseases (NCDs)
Select Entity,`Date`, `Cardiovascular diseases`, `Diabetes mellitus`, 
`Chronic kidney disease`,`Chronic respiratory diseases`, Neoplasms, 
`Cirrhosis and other chronic liver diseases`, `Digestive diseases`, 
`Alzheimers disease and other dementias`, `Parkinsons disease`
From deaths;

CREATE TABLE death_cat (
  Entity    VARCHAR(255),
  Year      INT,
  Category  VARCHAR(50),
  Cause     VARCHAR(100),
  Deaths    INT
);

INSERT INTO death_cat (Entity, Year, Category, Cause, Deaths)
-- Infectious diseases
SELECT Entity,
       CAST(`Date` AS UNSIGNED) AS Year,
       'Infectious'         AS Category,
       'Meningitis'         AS Cause,
       Meningitis           AS Deaths
  FROM deaths
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Infectious',
       'Malaria',
       Malaria
  FROM deaths
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Infectious',
       'HIV/AIDS',
       `HIV/AIDS`
  FROM deaths
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Infectious',
       'Tuberculosis',
       `Tuberculosis`
  FROM deaths
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Infectious',
       'Lower respiratory infections',
       `Lower respiratory infections`
  FROM deaths 
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Infectious',
       'Diarrheal diseases',
       `Diarrheal diseases`
  FROM deaths 
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Infectious',
       'Acute hepatitis',
       `Acute hepatitis`
  FROM deaths 
UNION ALL

-- Behavioral & Substance‑Use
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Behavioral',
       'Drug use disorders',
       `Drug use disorders`
  FROM deaths
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Behavioral',
       'Alcohol use disorders',
       `Alcohol use disorders`
  FROM deaths
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Behavioral',
       'Self-harm',
       `Self-harm`
  FROM deaths
UNION ALL

-- Chronic NCDs
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Chronic',
       'Cardiovascular diseases',
       `Cardiovascular diseases`
  FROM deaths
UNION ALL
SELECT Entity,
       CAST(`Date` AS UNSIGNED),
       'Chronic',
       'Diabetes mellitus',
       `Diabetes mellitus`
  FROM deaths
UNION ALL
SELECT
  Entity,
  CAST(`Date` AS UNSIGNED) AS Year,
  'Chronic'                    AS Category,
  'Chronic kidney disease'     AS Cause,
  `Chronic kidney disease`     AS Deaths
FROM deaths
UNION ALL
SELECT
  Entity,
  CAST(`Date` AS UNSIGNED),
  'Chronic',
  'Chronic respiratory diseases',
  `Chronic respiratory diseases`
FROM deaths
UNION ALL
SELECT
  Entity,
  CAST(`Date` AS UNSIGNED),
  'Chronic',
  'Neoplasms',
  Neoplasms
FROM deaths
UNION ALL
SELECT
  Entity,
  CAST(`Date` AS UNSIGNED),
  'Chronic',
  'Cirrhosis and other chronic liver diseases',
  `Cirrhosis and other chronic liver diseases`
FROM deaths
UNION ALL
SELECT
  Entity,
  CAST(`Date` AS UNSIGNED),
  'Chronic',
  'Digestive diseases',
  `Digestive diseases`
FROM deaths
UNION ALL
SELECT
  Entity,
  CAST(`Date` AS UNSIGNED),
  'Chronic',
  'Alzheimers disease and other dementias',
  `Alzheimers disease and other dementias`
FROM deaths
UNION ALL
SELECT
  Entity,
  CAST(`Date` AS UNSIGNED),
  'Chronic',
  'Parkinsons disease',
  `Parkinsons disease`
FROM deaths
;

-- Format Year Column
Update death_cat
Set `Year` = `Year`DIV 10000;

-- Deaths with Cause and Category
Select *
From death_cat;

-- Cause of Deaths by Country Over Time
SELECT
Entity AS Country, `Year`, Cause, SUM(Deaths) AS TotalDeaths
FROM death_cat
WHERE Cause In ('Cardiovascular diseases', 'Neoplasms')
GROUP BY Entity, `Year`, Cause
ORDER BY Cause, Entity, `Year`;


-- SELECT `Year`, Cause, SUM(Deaths) AS TotalDeaths
-- FROM death_cat
-- WHERE Cause IN (
--   'Cardiovascular diseases',
--   'Neoplasms',
--   'Alzheimers disease and other dementias',
--   'Self-harm',
--   'Alcohol use disorders',
--   'Drug use disorders'
-- )
-- GROUP BY `Year`, Cause
-- ORDER BY Cause,`Year`
;


