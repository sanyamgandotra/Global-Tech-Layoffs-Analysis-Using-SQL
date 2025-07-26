-- Data Cleaning

SELECT*
FROM layoffs
;

-- Remove Duplicates
-- Standardize the data
-- Null Values or Blank values
-- Remove any column

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT*
FROM layoffs_staging
;

INSERT layoffs_staging
SELECT*
FROM layoffs
;

SELECT*
FROM layoffs_staging
;

-- Row Number -- Ranking unique

SELECT*,
ROW_NUMBER()OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
;

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER()OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
)
SELECT*
FROM duplicate_cte
WHERE row_num>1
;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
SELECT*
FROM layoffs_staging2
;

INSERT INTO layoffs_staging2
SELECT*,
ROW_NUMBER()OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,'date', stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
;

SELECT*
FROM layoffs_staging2
WHERE row_num>1
;

DELETE
FROM layoffs_staging2
WHERE row_num>1
;

SELECT*
FROM layoffs_staging2
WHERE row_num>1
;

-- Standardizing Data

SELECT company, TRIM(company)
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET company = TRIM(company)
;

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT*
FROM layoffs_staging2
WHERE industry Like 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry Like 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1
;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United State%'
;

SELECT
    date,
    STR_TO_DATE(date, '%Y-%m-%d') AS converted_date
FROM
    layoffs_staging2;
    
UPDATE layoffs_staging2
SET date = STR_TO_DATE(date, '%Y-%m-%d')
;

ALTER TABLE layoffs_staging2
ADD COLUMN temp_date DATE;

UPDATE layoffs_staging2
SET temp_date = STR_TO_DATE(date, '%Y-%m-%d');

ALTER TABLE layoffs_staging2
DROP COLUMN date;

ALTER TABLE layoffs_staging2
CHANGE COLUMN temp_date date DATE;

ALTER TABLE layoffs_staging2
MODIFY COLUMN date DATE AFTER percentage_laid_off;

SELECT*
FROM layoffs_staging2;

-- dealing with NULL/blank values

SELECT*
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

SELECT*
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
;

SELECT*
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NULL
;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL
;

SELECT*
FROM layoffs_staging2
WHERE industry is NULL;

SELECT*
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT*
FROM layoffs_staging2;





