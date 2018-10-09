/****** Object:  StoredProcedure [dbo].[BinaryClockSQL]    Script Date: 09/10/2018 12:11:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BinaryClockSQL]
    @unicodeCharStyle tinyInt = 1,
    @binaryCalc bit = 1,
    @help bit = 0,
    @symbolList bit = 0
AS

/*
--SAMPLE TO EXECUTE PROCEDURE
EXECUTE dbo.BinaryClockSQL
@unicodeCharStyle = 30,
@symbolList = 1,
@binaryCalc = 1
*/

    DECLARE @Time TIME = CAST(GETDATE() AS TIME)
    DECLARE @On NVARCHAR(12);
    DECLARE @Off NVARCHAR(12);

    DECLARE @hh int, @mm int, @ss int
    SET @hh = DATEPART(HOUR,@Time);
    SET @mm = DATEPART(MINUTE, @Time);
    SET @ss = DATEPART(SECOND, @Time);

IF OBJECT_ID('tempdb..#charNcode') IS NOT NULL
    BEGIN
	   DROP TABLE #charNcode
    END

    CREATE TABLE #charNcode(
    [tinyintvalue] tinyint not null,
    [CharOn] NVARCHAR(12) not null,
    [CharOff] NVARCHAR(12) not null
    )

    INSERT INTO #charNcode ([tinyintvalue],[CharOn],[CharOff])
		    SELECT 1  AS [tinyintvalue], N'🌕' AS [CharOn], N'🌑' AS [CharOff]
    UNION ALL SELECT 2  AS [tinyintvalue], N'1' AS [CharOn], N'0' AS [CharOff]
    UNION ALL SELECT 3  AS [tinyintvalue], N'١' AS [CharOn], N'۰' AS [CharOff]
    UNION ALL SELECT 4  AS [tinyintvalue], N'𝟙' AS [CharOn], N'𝟘' AS [CharOff]
    UNION ALL SELECT 5  AS [tinyintvalue], N'〡' AS [CharOn], N'〇' AS [CharOff]
    UNION ALL SELECT 6  AS [tinyintvalue], N'⧲' AS [CharOn], N'⧳' AS [CharOff]
    UNION ALL SELECT 7  AS [tinyintvalue], N'◻' AS [CharOn], N'◼' AS [CharOff]
    UNION ALL SELECT 8  AS [tinyintvalue], N'⦾' AS [CharOn], N'⧇' AS [CharOff]
    UNION ALL SELECT 9  AS [tinyintvalue], N'⧮' AS [CharOn], N'⧯' AS [CharOff]
    UNION ALL SELECT 10 AS [tinyintvalue], N'⧰' AS [CharOn], N'⧱' AS [CharOff]
    UNION ALL SELECT 11 AS [tinyintvalue], N'⧬' AS [CharOn], N'⧭' AS [CharOff]
    UNION ALL SELECT 12 AS [tinyintvalue], N'⨴' AS [CharOn], N'⨵' AS [CharOff]
    UNION ALL SELECT 13 AS [tinyintvalue], N'⨭' AS [CharOn], N'⨮' AS [CharOff]
    UNION ALL SELECT 14 AS [tinyintvalue], N'⩔' AS [CharOn], N'⩓' AS [CharOff]
    UNION ALL SELECT 15 AS [tinyintvalue], N'✓' AS [CharOn], N'✗' AS [CharOff]
    UNION ALL SELECT 16 AS [tinyintvalue], N'☑' AS [CharOn], N'☒' AS [CharOff]
    UNION ALL SELECT 17 AS [tinyintvalue], N'☼' AS [CharOn], N'☀' AS [CharOff]
    UNION ALL SELECT 18 AS [tinyintvalue], N'♫' AS [CharOn], N'♩' AS [CharOff]
    UNION ALL SELECT 19 AS [tinyintvalue], N'☢' AS [CharOn], N'⭘' AS [CharOff]
    UNION ALL SELECT 20 AS [tinyintvalue], N'☣' AS [CharOn], N'⭘' AS [CharOff]
    UNION ALL SELECT 21 AS [tinyintvalue], N'☯' AS [CharOn], N'⭘' AS [CharOff]
    UNION ALL SELECT 22 AS [tinyintvalue], N'☠' AS [CharOn], N'⭘' AS [CharOff]
    UNION ALL SELECT 23 AS [tinyintvalue], N'⚠' AS [CharOn], N'⭘' AS [CharOff]
    UNION ALL SELECT 24 AS [tinyintvalue], N'⚕' AS [CharOn], N'⭘' AS [CharOff]
    UNION ALL SELECT 25 AS [tinyintvalue], N'♔' AS [CharOn], N'♚' AS [CharOff]
    UNION ALL SELECT 26 AS [tinyintvalue], N'♘' AS [CharOn], N'♞' AS [CharOff]
    UNION ALL SELECT 27 AS [tinyintvalue], N'♢' AS [CharOn], N'♦' AS [CharOff]
    UNION ALL SELECT 28 AS [tinyintvalue], N'◎' AS [CharOn], N'◉' AS [CharOff]
    UNION ALL SELECT 29 AS [tinyintvalue], N'👍' AS [CharOn], N'👎' AS [CharOff]
    UNION ALL SELECT 30 AS [tinyintvalue], N'⏵' AS [CharOn], N'⏹' AS [CharOff]
    UNION ALL SELECT 31 AS [tinyintvalue], N'֍' AS [CharOn], N'֎' AS [CharOff]
    UNION ALL SELECT 32 AS [tinyintvalue], N'🕷' AS [CharOn], N'🕸' AS [CharOff]
    UNION ALL SELECT 33 AS [tinyintvalue], N'🕂' AS [CharOn], N'🕀' AS [CharOff]
    UNION ALL SELECT 34 AS [tinyintvalue], N'🔊' AS [CharOn], N'🔈' AS [CharOff]
    UNION ALL SELECT 35 AS [tinyintvalue], N'💥' AS [CharOn], N'💣' AS [CharOff]
    UNION ALL SELECT 36 AS [tinyintvalue], N'💩' AS [CharOn], N'💨' AS [CharOff]

    IF(@symbolList = 1)
	   BEGIN
		  SELECT * FROM #charNcode;
	   END

    SELECT @On = [CharOn], @Off = [CharOff] FROM #charNcode WHERE [tinyintvalue] = @unicodeCharStyle;

    IF (@binaryCalc = 1)
	   BEGIN

		  SELECT 'Hour' AS [Time], 
		  CASE 
		      WHEN LEN(@hh) = 1 THEN '0'+CAST(@hh AS nvarchar(2))
		      ELSE CAST(@hh AS nvarchar(2)) 
		      END AS [Value]
		  ,CONCAT -- Full Binary representation
		  (CAST(@hh & power(2,7)     AS bit)
		  ,CAST(@hh & power(2,6)     AS bit)
		  ,CAST(@hh & power(2,5)     AS bit)
		  ,CAST(@hh & power(2,4)     AS bit)
		  ,CAST(@hh & power(2,3)     AS bit)
		  ,CAST(@hh & power(2,2)     AS bit)
		  ,CAST(@hh & power(2,1)     AS bit)
		  ,CAST(@hh & power(2,0)     AS bit) ) AS BitString
		  --Binary Columns
		  ,CASE 
		      WHEN CAST(@hh & power(2,7) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,7) AS bit) = 1 THEN @On
		  END AS BIT7
		  ,CASE 
		      WHEN CAST(@hh & power(2,6) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,6) AS bit) = 1 THEN @On
		  END AS BIT6
		  ,CASE 
		      WHEN CAST(@hh & power(2,5) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,5) AS bit) = 1 THEN @On
		  END AS BIT5
		  ,CASE 
		      WHEN CAST(@hh & power(2,4) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,4) AS bit) = 1 THEN @On
		  END AS BIT4
		  ,CASE 
		      WHEN CAST(@hh & power(2,3) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,3) AS bit) = 1 THEN @On
		  END AS BIT3
		  ,CASE 
		      WHEN CAST(@hh & power(2,2) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,2) AS bit) = 1 THEN @On
		  END AS BIT2
		  ,CASE 
		      WHEN CAST(@hh & power(2,1) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,1) AS bit) = 1 THEN @On
		  END AS BIT1
		  ,CASE 
		      WHEN CAST(@hh & power(2,0) AS bit) = 0 THEN @Off
		      WHEN CAST(@hh & power(2,0) AS bit) = 1 THEN @On
		  END AS BIT0
		  UNION ALL
		  SELECT 'Minute' AS [Time], 
		  CASE 
		      WHEN LEN(@mm) = 1 THEN '0'+CAST(@mm AS nvarchar(2))
		      ELSE CAST(@mm AS nvarchar(2)) 
		      END AS [Value]
		  ,CONCAT -- Full Binary representation
		  (CAST(@mm & power(2,7)     AS bit)
		  ,CAST(@mm & power(2,6)     AS bit)
		  ,CAST(@mm & power(2,5)     AS bit)
		  ,CAST(@mm & power(2,4)     AS bit)
		  ,CAST(@mm & power(2,3)     AS bit)
		  ,CAST(@mm & power(2,2)     AS bit)
		  ,CAST(@mm & power(2,1)     AS bit)
		  ,CAST(@mm & power(2,0)     AS bit) ) AS BitString
		  --Binary Columns
		  ,CASE 
		      WHEN CAST(@mm & power(2,7) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,7) AS bit) = 1 THEN @On
		  END AS BIT7
		  ,CASE 
		      WHEN CAST(@mm & power(2,6) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,6) AS bit) = 1 THEN @On
		  END AS BIT6
		  ,CASE 
		      WHEN CAST(@mm & power(2,5) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,5) AS bit) = 1 THEN @On
		  END AS BIT5
		  ,CASE 
		      WHEN CAST(@mm & power(2,4) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,4) AS bit) = 1 THEN @On
		  END AS BIT4
		  ,CASE 
		      WHEN CAST(@mm & power(2,3) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,3) AS bit) = 1 THEN @On
		  END AS BIT3
		  ,CASE 
		      WHEN CAST(@mm & power(2,2) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,2) AS bit) = 1 THEN @On
		  END AS BIT2
		  ,CASE 
		      WHEN CAST(@mm & power(2,1) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,1) AS bit) = 1 THEN @On
		  END AS BIT1
		  ,CASE 
		      WHEN CAST(@mm & power(2,0) AS bit) = 0 THEN @Off
		      WHEN CAST(@mm & power(2,0) AS bit) = 1 THEN @On
		  END AS BIT0
		  UNION ALL
		  SELECT 'Second' AS [Time], 
		  CASE 
		      WHEN LEN(@ss) = 1 THEN '0'+CAST(@ss AS nvarchar(2))
		      ELSE CAST(@ss AS nvarchar(2)) 
		      END AS [Value]
		  ,CONCAT -- Full Binary representation
		  (CAST(@SS & power(2,7) AS bit)
		  ,CAST(@SS & power(2,6) AS bit)
		  ,CAST(@SS & power(2,5) AS bit)
		  ,CAST(@SS & power(2,4) AS bit)
		  ,CAST(@SS & power(2,3) AS bit)
		  ,CAST(@SS & power(2,2) AS bit)
		  ,CAST(@SS & power(2,1) AS bit)
		  ,CAST(@SS & power(2,0) AS bit)) AS BitString
		  --Binary Columns
		  ,CASE 
		      WHEN CAST(@SS & power(2,7) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,7) AS bit) = 1 THEN @On
		  END AS BIT7
		  ,CASE 
		      WHEN CAST(@SS & power(2,6) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,6) AS bit) = 1 THEN @On
		  END AS BIT6
		  ,CASE 
		      WHEN CAST(@SS & power(2,5) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,5) AS bit) = 1 THEN @On
		  END AS BIT5
		  ,CASE 
		      WHEN CAST(@SS & power(2,4) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,4) AS bit) = 1 THEN @On
		  END AS BIT4
		  ,CASE 
		      WHEN CAST(@SS & power(2,3) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,3) AS bit) = 1 THEN @On
		  END AS BIT3
		  ,CASE 
		      WHEN CAST(@SS & power(2,2) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,2) AS bit) = 1 THEN @On
		  END AS BIT2
		  ,CASE 
		      WHEN CAST(@SS & power(2,1) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,1) AS bit) = 1 THEN @On
		  END AS BIT1
		  ,CASE 
		      WHEN CAST(@SS & power(2,0) AS bit) = 0 THEN @Off
		      WHEN CAST(@SS & power(2,0) AS bit) = 1 THEN @On
		  END AS BIT0
	   END

    ELSE IF (@binaryCalc = 0)
	   BEGIN
		  SELECT 'Hour' AS [Time], 
		  CASE 
			 WHEN LEN(@hh) = 1 THEN '0'+CAST(@hh AS nvarchar(2))
			 ELSE CAST(@hh AS nvarchar(2)) 
		  END AS [Value]
		  ,CONCAT -- Full Binary representation
		  (CAST(@hh & power(2,7) AS bit)
		  ,CAST(@hh & power(2,6) AS bit)
		  ,CAST(@hh & power(2,5) AS bit)
		  ,CAST(@hh & power(2,4) AS bit)
		  ,CAST(@hh & power(2,3) AS bit)
		  ,CAST(@hh & power(2,2) AS bit)
		  ,CAST(@hh & power(2,1) AS bit)
		  ,CAST(@hh & power(2,0) AS bit)) AS BitString
		  --Integer Value
		  ,CASE 
		   WHEN CAST(@hh & power(2,7) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,7) AS bit) = 1 THEN CAST(128 AS INT)
		   END AS BIT7 
		  ,CASE 
		   WHEN CAST(@hh & power(2,6) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,6) AS bit) = 1 THEN CAST(64 AS INT)
		   END AS BIT6 
		  ,CASE 
		   WHEN CAST(@hh & power(2,5) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,5) AS bit) = 1 THEN CAST(32 AS INT)
		   END AS BIT5
		  ,CASE 
		   WHEN CAST(@hh & power(2,4) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,4) AS bit) = 1 THEN CAST(16 AS INT)
		   END AS BIT4
		  ,CASE 
		   WHEN CAST(@hh & power(2,3) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,3) AS bit) = 1 THEN CAST(1*8 AS INT)
		   END AS BIT3
		  ,CASE 
		   WHEN CAST(@hh & power(2,2) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,2) AS bit) = 1 THEN CAST(4 AS INT)
		   END AS BIT2
		  ,CASE 
		   WHEN CAST(@hh & power(2,1) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,1) AS bit) = 1 THEN CAST(2 AS INT)
		   END AS BIT1 
		  ,CASE 
		   WHEN CAST(@hh & power(2,0) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@hh & power(2,0) AS bit) = 1 THEN CAST(1 AS INT)
		   END AS BIT0
		  UNION ALL
		  SELECT 'Minutes' AS [Time], 
		  CASE 
		      WHEN LEN(@mm) = 1 THEN '0'+CAST(@mm AS nvarchar(2))
		      ELSE CAST(@mm AS nvarchar(2)) 
		      END AS [Value]
		  ,CONCAT -- Full Binary representation
		  (CAST(@mm & power(2,7) AS bit)
		  ,CAST(@mm & power(2,6) AS bit)
		  ,CAST(@mm & power(2,5) AS bit)
		  ,CAST(@mm & power(2,4) AS bit)
		  ,CAST(@mm & power(2,3) AS bit)
		  ,CAST(@mm & power(2,2) AS bit)
		  ,CAST(@mm & power(2,1) AS bit)
		  ,CAST(@mm & power(2,0) AS bit)) AS BitString
		  --Integer Value
		  ,CASE 
		   WHEN CAST(@mm & power(2,7) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,7) AS bit) = 1 THEN CAST(128 AS INT)
		   END AS BIT7 
		  ,CASE 
		   WHEN CAST(@mm & power(2,6) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,6) AS bit) = 1 THEN CAST(64 AS INT)
		   END AS BIT6 
		  ,CASE 
		   WHEN CAST(@mm & power(2,5) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,5) AS bit) = 1 THEN CAST(32 AS INT)
		   END AS BIT5
		  ,CASE 
		   WHEN CAST(@mm & power(2,4) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,4) AS bit) = 1 THEN CAST(16 AS INT)
		   END AS BIT4
		  ,CASE 
		   WHEN CAST(@mm & power(2,3) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,3) AS bit) = 1 THEN CAST(1*8 AS INT)
		   END AS BIT3
		  ,CASE 
		   WHEN CAST(@mm & power(2,2) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,2) AS bit) = 1 THEN CAST(4 AS INT)
		   END AS BIT2
		  ,CASE 
		   WHEN CAST(@mm & power(2,1) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,1) AS bit) = 1 THEN CAST(2 AS INT)
		   END AS BIT1 
		  ,CASE 
		   WHEN CAST(@mm & power(2,0) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@mm & power(2,0) AS bit) = 1 THEN CAST(1 AS INT)
		   END AS BIT0
		  UNION ALL
		  SELECT 'Seconds' AS [Time], 
		  CASE 
		      WHEN LEN(@ss) = 1 THEN '0'+CAST(@ss AS nvarchar(2))
		      ELSE CAST(@ss AS nvarchar(2)) 
		      END AS [Value]
		  ,CONCAT -- Full Binary representation
		  (CAST(@SS & power(2,7) AS bit)
		  ,CAST(@SS & power(2,6) AS bit)
		  ,CAST(@SS & power(2,5) AS bit)
		  ,CAST(@SS & power(2,4) AS bit)
		  ,CAST(@SS & power(2,3) AS bit)
		  ,CAST(@SS & power(2,2) AS bit)
		  ,CAST(@SS & power(2,1) AS bit)
		  ,CAST(@SS & power(2,0) AS bit)) AS BitString
		  --Integer Value
		  ,CASE 
		   WHEN CAST(@SS & power(2,7) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,7) AS bit) = 1 THEN CAST(128 AS INT)
		   END AS BIT7 
		  ,CASE 
		   WHEN CAST(@SS & power(2,6) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,6) AS bit) = 1 THEN CAST(64 AS INT)
		   END AS BIT6 
		  ,CASE 
		   WHEN CAST(@SS & power(2,5) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,5) AS bit) = 1 THEN CAST(32 AS INT)
		   END AS BIT5
		  ,CASE 
		   WHEN CAST(@SS & power(2,4) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,4) AS bit) = 1 THEN CAST(16 AS INT)
		   END AS BIT4
		  ,CASE 
		   WHEN CAST(@SS & power(2,3) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,3) AS bit) = 1 THEN CAST(1*8 AS INT)
		   END AS BIT3
		  ,CASE 
		   WHEN CAST(@SS & power(2,2) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,2) AS bit) = 1 THEN CAST(4 AS INT)
		   END AS BIT2
		  ,CASE 
		   WHEN CAST(@SS & power(2,1) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,1) AS bit) = 1 THEN CAST(2 AS INT)
		   END AS BIT1 
		  ,CASE 
		   WHEN CAST(@SS & power(2,0) AS bit) = 0 THEN CAST(0 AS INT)
		   WHEN CAST(@SS & power(2,0) AS bit) = 1 THEN CAST(1 AS INT)
		   END AS BIT0
END
