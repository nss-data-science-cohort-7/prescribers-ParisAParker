-- Question 1a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.
SELECT npi, SUM(p2.total_claim_count) as total_claims
FROM prescriber as p1
INNER JOIN prescription as p2
USING(npi)
GROUP BY npi
ORDER BY total_claims DESC;
--Answer - npi: 1881634483 & total_claims: 99707

-- Question 1b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, and the total number of claims.
SELECT p1.nppes_provider_first_name, p1.nppes_provider_last_org_name, p1.specialty_description, SUM(p2.total_claim_count) AS total_claims
FROM prescriber as p1
INNER JOIN prescription as p2
USING(npi)
GROUP BY 1,2,3
ORDER BY total_claims DESC;
--Answer - Bruce Pendley/ Family Practice

-- Question 2a. Which specialty had the most total number of claims (totaled over all drugs)?
SELECT p1.specialty_description, SUM(p2.total_claim_count) AS total_claims
FROM prescriber AS p1
INNER JOIN prescription AS p2
USING(npi)
GROUP BY 1
ORDER BY 2 DESC;
--Answer: Family Practice 

-- Question 2b. Which specialty had the most total number of claims for opioids?
SELECT p1.specialty_description, SUM(p2.total_claim_count) AS total_claims
FROM prescriber AS p1
INNER JOIN prescription AS p2
USING(npi)
INNER JOIN drug AS p3
USING(drug_name)
WHERE opioid_drug_flag = 'Y'
GROUP BY 1
ORDER BY total_claims DESC;
--Answer: Nurse Practitioner

-- Question 2c. Challenge Question: Are there any specialties that appear in the prescriber table that have no associated prescriptions in the prescription table?


-- Question 2d. Difficult Bonus: Do not attempt until you have solved all other problems! For each specialty, report the percentage of total claims by that specialty which are for opioids. Which specialties have a high percentage of opioids?


-- Question 3a. Which drug (generic_name) had the highest total drug cost?
SELECT p2.generic_name, SUM(p1.total_drug_cost) AS total_drug_cost
FROM prescription AS p1
INNER JOIN drug AS p2
USING(drug_name)
WHERE total_drug_cost IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
--Answer - INSULIN GLARGINE, HUM.REC.ANLOG

-- Question 3b. Which drug (generic_name) has the highest total cost per day? Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.
SELECT p2.generic_name, p1.total_30_day_fill_count AS day_count, p1.total_drug_cost AS total_drug_cost, ((total_drug_cost /total_30_day_fill_count)/30) AS cost_per_day
FROM prescription AS p1
INNER JOIN drug AS p2
USING(drug_name)
WHERE total_drug_cost IS NOT NULL
ORDER BY 4 DESC;
--Answer - ASFOTASE ALFA

-- Question 4a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.

-- Question 4b. Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.

-- Question 5a. How many CBSAs are in Tennessee? Warning: The cbsa table contains information for all states, not just Tennessee.

-- Question 5b. Which cbsa has the largest combined population? Which has the smallest? Report the CBSA name and total population.

-- Question 5c. What is the largest (in terms of population) county which is not included in a CBSA? Report the county name and population.

-- Question 6a. Find all rows in the prescription table where total_claims is at least 3000. Report the drug_name and the total_claim_count.

-- Question 6b. For each instance that you found in part a, add a column that indicates whether the drug is an opioid.

-- Question 6c. Add another column to you answer from the previous part which gives the prescriber first and last name associated with each row.

-- Question 7 The goal of this exercise is to generate a full list of all pain management specialists in Nashville and the number of claims they had for each opioid. Hint: The results from all 3 parts will have 637 rows.

-- Question 7a. First, create a list of all npi/drug_name combinations for pain management specialists (specialty_description = 'Pain Management) in the city of Nashville (nppes_provider_city = 'NASHVILLE'), where the drug is an opioid (opiod_drug_flag = 'Y'). Warning: Double-check your query before running it. You will only need to use the prescriber and drug tables since you don't need the claims numbers yet.

-- Question 7b. Next, report the number of claims per drug per prescriber. Be sure to include all combinations, whether or not the prescriber had any claims. You should report the npi, the drug name, and the number of claims (total_claim_count).

-- Question 7c. Finally, if you have not done so already, fill in any missing values for total_claim_count with 0. Hint - Google the COALESCE function.