  insert `csv_data.population2`
  select *
  from `csv_data.population`

--- change column names to appropriate names

  CREATE OR REPLACE TABLE `csv_data.population_clean` AS
  SELECT
  `Country Name` AS country, 
  `Country Code` AS country_code,
  `Series Name` AS gender,
  `Series Code` AS series_code,
  `2020 _YR2020_` AS `2020`,  -- Renaming 2020_YR2020_ to 2020
  `2021 _YR2021_` AS `2021`,  -- Renaming 2021_YR2021_ to 2021
  `2022 _YR2022_` AS `2022`,  -- Renaming 2022_YR2022_ to 2022
  `2023 _YR2023_` AS `2023`,  -- Renaming 2023_YR2023_ to 2023
  `2024 _YR2024_` AS `2024`   -- Renaming 2024_YR2024_ to 2024
  FROM
  `csv_data.population2`;

  --- check & view for nulls then remove if not needed
  select *
  from `csv_data.population_clean`
  where country is null or country_code is null or gender is null or series_code is null or
        '2020' is null or '2021' is null or '2022' is null or '2023' is null or '2024' is null
  
  ---remove all nulls 
  select*
  from `csv_data.population_clean`
  where country is not null and country_code is not null

  DELETE FROM `csv_data.population_clean`
  WHERE country IS NULL 
  OR country_code IS NULL;

  --- look for any duplicates and remove if not needed
  select country, count(*)
  from `csv_data.population_clean`
  group by country
  having count(*) >1; --since male and female column is in one all countries will have duplicates so try with 2

  select country, count(*)
  from `csv_data.population_clean`
  group by country
  having count(*) >2; --- no duplicate was found

  ---remove population word with in the gender column 
  UPDATE `csv_data.population_clean`
  SET gender = REPLACE(gender, 'Population,', '')
  WHERE gender LIKE '%Population,%';

  ---remove extra spacing from gender column 
  UPDATE `csv_data.population_clean`
  SET gender = TRIM(gender)
  WHERE gender IS NOT NULL;

  --- Add comma on all numbers for all rows in year columns 
  SELECT 
  FORMAT('%0.0f', `2020`) AS formatted_2020
  FROM `csv_data.population_clean`
  WHERE `2020` IS NOT NULL;

  --- make sure each cloumn has appropriate data type
  SELECT
  column_name,
  data_type
  FROM
  `csv_data.INFORMATION_SCHEMA.COLUMNS`
  WHERE
  table_name = 'population_clean';


  --- Remove unneeded columns 
  Alter table `csv_data.population_clean`
  drop column country_code;

  Alter table `csv_data.population_clean`
  drop column series_code;
  
  Alter table `csv_data.population_clean`
  drop column `2024`;

  Alter table `csv_data.population_clean`
  drop column male_population;
 
  Alter table `csv_data.population_clean`
  drop column female_population;

  --- analyze the data - max population --- china was the most populated in 2020
  SELECT 
  country,
  SUM(SAFE_CAST(`2020` AS INT64)) AS total_population_2020
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2020` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2020 desc
  LIMIT 1;                            

  --- analyze min population ---Tuvalu was the least populated in 2020
  SELECT 
  country,
  SUM(SAFE_CAST(`2020` AS INT64)) AS total_population_2020
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2020` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2020 asc
  LIMIT 1;     

  --- 2021 max population --- India was the most populated in 2021
  SELECT 
  country,
  SUM(SAFE_CAST(`2021` AS INT64)) AS total_population_2021
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2021` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2021 desc
  LIMIT 1;        

---2021 min population --- Tuvalu
  SELECT 
  country,
  SUM(SAFE_CAST(`2021` AS INT64)) AS total_population_2021
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2021` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2021 asc
  LIMIT 1;  

  --- 2022 max popualtion --- India
  SELECT 
  country,
  SUM(SAFE_CAST(`2022` AS INT64)) AS total_population_2022
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2022` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2022 desc
  LIMIT 1;  

  --- 2022 min population --- Tuvalu
  SELECT 
  country,
  SUM(SAFE_CAST(`2022` AS INT64)) AS total_population_2022
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2022` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2022 asc
  LIMIT 1;  

  ---2023 max population --- India
  SELECT 
  country,
  SUM(SAFE_CAST(`2023` AS INT64)) AS total_population_2023
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2023` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2023 desc
  LIMIT 1; 

  ---2023 min population --- Tuvalu
  SELECT 
  country,
  SUM(SAFE_CAST(`2023` AS INT64)) AS total_population_2023
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2023` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2023 asc
  LIMIT 1; 

  ---2024 max population --- India
  SELECT 
  country,
  SUM(SAFE_CAST(`2024` AS INT64)) AS total_population_2024
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2024` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2024 desc
  LIMIT 1; 

  ---2024 min population --- Tuvalu
  SELECT 
  country,
  SUM(SAFE_CAST(`2024` AS INT64)) AS total_population_2024
  FROM 
  `csv_data.population_clean`
  WHERE 
  `gender` IN ('male', 'female') AND `2024` IS NOT NULL
  GROUP BY 
  country
  ORDER BY 
  total_population_2024 asc
  LIMIT 1; 

  




  ---analyze which gender had the biggest & lowest population in 2020, country 
  SELECT country,gender,`2020`
  FROM`csv_data.population_clean`
  WHERE
  gender = (
    SELECT gender
    FROM `csv_data.population_clean`
    GROUP BY gender
    ORDER BY SUM(CAST(`2020` AS INT64)) DESC
    LIMIT 1
  )
  ORDER BY
  `2020` asc
  LIMIT 1;  --- male in Tuvalu have the lowest population in 2020

  SELECT
  country,
  gender,
  `2020`
  FROM
  `csv_data.population_clean`
  WHERE
  gender = (
    SELECT gender
    FROM `csv_data.population_clean`
    GROUP BY gender
    ORDER BY SUM(CAST(`2020` AS INT64)) DESC
    LIMIT 1
  )
  ORDER BY
  `2020` desc
  LIMIT 1;  --- male in india have the highest population in 2020

  