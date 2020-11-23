-- List the country with the first case and that date.
SELECT D.Country, D.Day
FROM
     (SELECT MIN(MinDay.minday) AS mini
      FROM 
          (SELECT Country, MIN(Day) AS minday
           FROM GlobalDailyCases
           WHERE Cases > 0
           GROUP BY Country) AS MinDay) AS Mini,
      GlobalDailyCases AS D 
WHERE
     D.Day = Mini.mini AND
     D.Cases > 0

-- List the names of top ten countries with highest cumulative cases and their cumulative cases
SELECT TOP 10 T.Country, T.tot_cases
FROM
     (SELECT Country, SUM(Cases) AS tot_cases
      FROM GlobalDailyCases
      GROUP BY Country) AS T
ORDER BY tot_cases DESC;

/*second method, to be test on real data*/
SELECT * 
FROM (SELECT row_number() OVER (ORDER BY T.tot_cases DESC) AS Country_Rank 
            T.Country, 
            T.tot_cases
            
     FROM 
         (SELECT Country, SUM(Cases) AS tot_cases
          FROM GlobalDailyCases
          GROUP BY Country) AS T) AS ranks
WHERE Country_Rank <= 10;

-- List the top ten countries with highest deaths cases.
SELECT TOP 10 T.Country 
FROM
     (SELECT Country, SUM(Deaths) AS tot_deaths
      FROM GlobalDailyCases
      GROUP BY Country) AS T
ORDER BY tot_deaths DESC;

-- List the top ten countries with highest deaths/cumulative cases rate.
SELECT TOP 10 T.Country 
FROM
     (SELECT Country, SUM(Deaths)/SUM(Cases) AS death_rate
      FROM GlobalDailyCases
      GROUP BY Country) AS T
ORDER BY death_rate DESC;

-- List the State in the US with highest cumulative cases.
SELECT UNIQUE U.State
FROM(SELECT TOP 1 T.StateCode AS StateCode
     FROM
          (SELECT StateCode, SUM(Cases) AS tot_cases
           FROM UsDailyCases
           GROUP BY State) AS T
     ORDER BY tot_cases DESC) AS MaxStateCode,

     UsStateInfo AS U
WHERE
     U.StateCode = MaxStateCode.StateCode;

-- List the State in the US with highest deaths/cumulative.
SELECT UNIQUE U.State
FROM(SELECT TOP 1 T.StateCode AS StateCode
     FROM
          (SELECT StateCode, SUM(Deaths)/SUM(Cases) AS death_rate 
           FROM UsDailyCases
           GROUP BY State) AS T
     ORDER BY death_rate  DESC) AS MaxStateCode,

     UsStateInfo AS U
WHERE
     U.StateCode = MaxStateCode.StateCode;

-- List the State in the US with the requirement of Quarantine.
SELECT UsStateInfo
FROM UsStateInfo
WHERE ShutDownLevel = 2;