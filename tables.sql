DROP TABLE GlobalDailyCases;
CREATE TABLE GlobalDailyCases(
	Country VARCHAR(15),
	Cases INTEGER,
	Deaths INTEGER,
	Day DATE
);

DROP TABLE USDailyCases;
CREATE TABLE USDailyCases(
	StateCode VARCHAR(2),
	Cases INTERGE,
	Deaths INTEGER,
	Day DATE
);

DROP TABLE CountryInfo;
CREATE TABLE CountryInfo(
	CountryCode VARCHAR(3),
	Country VARCHAR(15),
	Population INTEGER,
	Continent VARCHAR(15)
);

DROP TABLE UsStateInfo;
CREATE TABLE UsStateInfo(
	StateCode VARCHAR(2),
	State VARCHAR(15),
	Population INTEGER,
	AREA DECIMAL(6,2),
	ShutDownLevel INTEGER
);