/*
These are stored procedures for the YaSamurai tables
Create By: Yarnell Locklear
Date: 9-18-2025
*/
use YaSamurai;

/*Double Bottom W Procedure*/

/* ---------- 1) Return the last row ---------- */
/* EXEC dbo.GetLastDoubleBottomW;*/
DROP PROCEDURE IF EXISTS dbo.GetLastDoubleBottomW;
GO
CREATE PROCEDURE dbo.GetLastDoubleBottomW
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 *
    FROM dbo.DoubleBottomW
    ORDER BY Id DESC;       -- “last row” = highest Id
END
GO


/* ---------- 2) Check if the last row matches given parameters ---------- */
/*-----------
DECLARE @IsMatch BIT;

EXEC dbo.CheckLastDoubleBottomWMatch
    @FirstLowBarDate   = '2025-09-20 15:36:00.000',
    @FirstLowBarPrice  = 115835.810000,
    @FirstLowBarCount  = 3,
    @SecondLowBarDate  = '2025-09-20 15:29:00.000',
    @SecondLowBarPrice = 115831.270000,
    @SecondLowBarCount = 10,
    @HighBarDate       = '2025-09-20 15:33:00.000',
    @HighBarPrice      = 115870.910000,
    @HighBarCount      = 6,
    @LeftSideWTime     = '2025-09-20 15:25:00.000',
    @LeftSideWPrice    = 115882.890000,
    @LeftSideWBarCount = 14,
    @IsMatch           = @IsMatch OUTPUT;

SELECT @IsMatch AS IsMatch; 
------------*/

/*-- 1 = matches last row, 0 = not*/
DROP PROCEDURE IF EXISTS dbo.CheckLastDoubleBottomWMatch;
GO
CREATE PROCEDURE dbo.CheckLastDoubleBottomWMatch
    @FirstLowBarDate    DATETIME,
    @FirstLowBarPrice   DECIMAL(18,6),
    @FirstLowBarCount   INT,
    @SecondLowBarDate   DATETIME,
    @SecondLowBarPrice  DECIMAL(18,6),
    @SecondLowBarCount  INT,
    @HighBarDate        DATETIME,
    @HighBarPrice       DECIMAL(18,6),
    @HighBarCount       INT,
    @LeftSideWTime      DATETIME,
    @LeftSideWPrice     DECIMAL(18,6),
    @LeftSideWBarCount  INT,
    @IsMatch            BIT OUTPUT        -- result: 1 = matches, 0 = not
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH LastRow AS
    (
        SELECT TOP (1) *
        FROM dbo.DoubleBottomW
        ORDER BY Id DESC
    )
    SELECT @IsMatch =
        CASE WHEN EXISTS
        (
            SELECT 1
            FROM LastRow L
            WHERE
                L.FirstLowBarDate   = @FirstLowBarDate
            AND L.FirstLowBarPrice  = @FirstLowBarPrice
            AND L.FirstLowBarCount  = @FirstLowBarCount
            AND L.SecondLowBarDate  = @SecondLowBarDate
            AND L.SecondLowBarPrice = @SecondLowBarPrice
            AND L.SecondLowBarCount = @SecondLowBarCount
            AND L.HighBarDate       = @HighBarDate
            AND L.HighBarPrice      = @HighBarPrice
            AND L.HighBarCount      = @HighBarCount
            AND L.LeftSideWTime     = @LeftSideWTime
            AND L.LeftSideWPrice    = @LeftSideWPrice
            AND L.LeftSideWBarCount = @LeftSideWBarCount
        )
        THEN 1 ELSE 0 END;
END
GO
