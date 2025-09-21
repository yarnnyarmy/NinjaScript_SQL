/*
These are create statements for the YaSamurai tables
Create By: Yarnell Locklear
Date: 9-16-2025
*/
use YaSamurai;

/*Double Bottom W Table*/
/*SELECT * FROM dbo.DoubleBottomW;
SELECT * FROM dbo.DoubleBottomW ORDER BY Id DESC;
EXEC dbo.GetLastDoubleBottomW;
TRUNCATE TABLE dbo.DoubleBottomW;
*/

DROP TABLE IF EXISTS DoubleBottomW;
CREATE TABLE DoubleBottomW
(
    Id INT IDENTITY(1,1) PRIMARY KEY,   -- unique key for each record

    FirstLowBarDate   DATETIME      NOT NULL,
    FirstLowBarPrice  DECIMAL(18,6) NOT NULL,
    FirstLowBarCount  INT           NOT NULL,

    SecondLowBarDate  DATETIME      NOT NULL,
    SecondLowBarPrice DECIMAL(18,6) NOT NULL,
    SecondLowBarCount INT           NOT NULL,

    HighBarDate       DATETIME      NOT NULL,
    HighBarPrice      DECIMAL(18,6) NOT NULL,
    HighBarCount      INT           NOT NULL,

    LeftSideWTime     DATETIME      NOT NULL,
    LeftSideWPrice    DECIMAL(18,6) NOT NULL,
    LeftSideWBarCount INT           NOT NULL
);
