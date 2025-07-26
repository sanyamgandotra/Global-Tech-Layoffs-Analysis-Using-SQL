-- Exploratory Data Analysis

SELECT*
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
;

SELECT MIN(date), MAX(date)
FROM layoffs_staging2
;

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 DESC
;

SELECT substring(date, 1,7) AS 'Month', SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(date, 1,7) IS NOT NULL
GROUP BY substring(date, 1,7)
ORDER BY 1 ASC
;

WITH Rolling_total AS
(
	SELECT substring(date, 1,7) AS Mnth, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(date, 1,7) IS NOT NULL
GROUP BY substring(date, 1,7)
ORDER BY 1 ASC
)
SELECT Mnth, total_off , SUM(total_off)OVER(ORDER BY Mnth) AS rolling_total
FROM Rolling_total;

SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
ORDER BY 1 ASC;

SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
ORDER BY 3 DESC;

WITH Company_year (company, year,total_laid_off) AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
), Company_year_rank AS
(
SELECT*, DENSE_RANK()OVER(PARTITION BY year ORDER BY total_laid_off DESC) AS Ranking
FROM Company_year
WHERE year IS NOT NULL
ORDER BY Ranking
)
SELECT*
FROM Company_year_rank
WHERE Ranking<=5
ORDER BY total_laid_off DESC
;

