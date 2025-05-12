use hospital;
describe hospital;

UPDATE Hospital
SET Gender = 'Male'
WHERE Gender = 'M';

UPDATE Hospital
SET Gender = 'Female'
WHERE Gender = 'F';


ALTER TABLE Hospital CHANGE `ï»¿Id` `Id` TEXT;
ALTER TABLE Hospital DROP COLUMN MyUnknownColumn;


DESCRIBE hospital;
-- Q1) What is the average patient age by gender and race?
SELECT Gender, Race, ROUND(AVG(Age),2) AS Avg_Age FROM hospital
GROUP BY Gender, Race
ORDER BY Avg_Age DESC;


-- Q2) How many patients were admitted versus not admitted based on the Patient Admission Flag?
SELECT Admission_Flag, COUNT(Id) AS Total FROM Hospital
GROUP BY Admission_Flag
ORDER BY Total DESC;


-- Q3) What is the distribution of patient admissions by Department Referral?
SELECT Department_Referral, COUNT(Id) AS Total FROM Hospital
GROUP BY Department_Referral
ORDER BY Total DESC;

-- Q4) What is the average Patient Satisfaction Score for each Department Referral?
SELECT Department_Referral, ROUND(AVG(Satisfaction_Score),2) AS Average_Score FROM Hospital
GROUP BY Department_Referral
ORDER BY Average_Score DESC;

-- Q5) How does Patient Waittime vary by Patient Admission Flag?
SELECT Admission_Flag, ROUND(AVG(Wait_time),2) AS Avg_Wait_Time FROM hospital
GROUP BY Admission_Flag;


-- Q6) What is the trend of patient admissions over time based on Patient Admission Date?
SELECT DATE_FORMAT(ADMISSION_DATE, '%Y - %M') AS Admission_Month, COUNT(ID) AS Total FROM HOSPITAL
GROUP BY Admission_Month
ORDER BY Total DESC;

-- Q7) Which patient race has the highest average Patient Satisfaction Score?
SELECT RACE, ROUND(AVG(SATISFACTION_SCORE),2) AS Average_Score FROM HOSPITAL
GROUP BY RACE
ORDER BY AVERAGE_SCORE DESC
LIMIT 1;


-- Q8) How does Patient Satisfaction Score correlate with Patient Waittime?
SELECT 
    CASE
        WHEN Wait_Time <= 10 THEN '0-10'
        WHEN Wait_Time <= 20 THEN '11-20'
        ELSE '21+'
    END AS Wait_Time_Range,
    ROUND(AVG(Satisfaction_Score), 2) AS Avg_Satisfaction
FROM hospital
WHERE Satisfaction_Score IS NOT NULL AND Wait_Time IS NOT NULL
GROUP BY Wait_Time_Range
ORDER BY Avg_Satisfaction DESC;


-- Q9) What is the count of patients by Patient Gender and Department Referral?
SELECT DEPARTMENT_REFERRAL, GENDER, COUNT(ID) AS Total FROM HOSPITAL
GROUP BY GENDER, DEPARTMENT_REFERRAL
ORDER BY Total DESC;

-- Q10) Which age group (e.g., 0-18, 19-35, 36-50, 51+) has the longest average Patient Waittime?
SELECT 
       CASE
           WHEN AGE <= 20 THEN '0-20'
           WHEN AGE <= 30 THEN '21-30'
           WHEN AGE <= 40 THEN '31-40'
           WHEN AGE <= 50 THEN '41-50'
           WHEN AGE <= 60 THEN '51-60'
           WHEN AGE <= 70 THEN '61-70'
           ELSE '71+'
       END AS Age_Group,
       ROUND(AVG(Wait_time),2) As Total
FROM HOSPITAL
GROUP BY Age_group
ORDER BY Total DESC;

-- Q11) How many patients were admitted on weekends versus weekdays based on Patient Admission Date?
SELECT 
    CASE
        WHEN date_format(ADMISSION_DATE, '%W') IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Days,
    COUNT(ADMISSION_DATE) AS Total
FROM HOSPITAL
WHERE Admission_Flag = 'True'
GROUP BY Days
ORDER BY Total DESC;

-- Q12) What is the average Patient Satisfaction Score for patients admitted versus not admitted?
SELECT ADMISSION_FLAG, ROUND(Avg(Satisfaction_Score),2) AS Avg_Satisfaction FROM HOSPITAL
GROUP BY ADMISSION_FLAG
ORDER BY Avg_Satisfaction DESC;


-- Q13) Which Department Referral has the highest number of non-admitted patients?
SELECT Department_Referral, COUNT(Department_Referral) As Total from Hospital
WHERE Admission_Flag = 'False'
GROUP BY Department_Referral
ORDER BY Total DESC
LIMIT 1;

-- Q14) How does Patient Satisfaction Score vary by Patient Age and Patient Gender?
SELECT
	CASE
           WHEN AGE <= 20 THEN '0-20'
           WHEN AGE <= 30 THEN '21-30'
           WHEN AGE <= 40 THEN '31-40'
           WHEN AGE <= 50 THEN '41-50'
           WHEN AGE <= 60 THEN '51-60'
           WHEN AGE <= 70 THEN '61-70'
           ELSE '71+'
       END AS Age_Group,
Gender,ROUND(AVG(SATISFACTION_SCORE),2) AS Avg_Satisfaction FROM HOSPITAL
GROUP BY Age_Group,Gender
ORDER BY Avg_Satisfaction DESC;


-- Q15) What is the monthly average Patient Waittime for each Department Referral?
SELECT Department_Referral, DATE_FORMAT(Admission_Date, '%Y - %m') AS Admission_Month,ROUND(AVG(Wait_Time),2) AS Avg_Wait_Time FROM HOSPITAL
GROUP BY DEPARTMENT_REFERRAL, Admission_Month
ORDER BY avg_wait_time DESC;