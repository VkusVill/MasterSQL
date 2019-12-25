SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[ParsingStr_old](
  @InputStr nvarchar(max),
  @Delimeter nvarchar(5)
)
RETURNS @table_res table(val varchar(50))
AS 
BEGIN
 
  -- определяем позицию первого разделителя
  DECLARE @pos int = CHARINDEX(@Delimeter, @InputStr)
   
  -- создаем переменную для хранения  
  DECLARE @val nvarchar(100)
      
  WHILE (@pos != 0)
  BEGIN      
      SET @val = SUBSTRING(@InputStr, 1, @pos-1)
      -- записываем в таблицу
      INSERT INTO @table_res (val) 
      SELECT RTRIM(LTRIM(@val))
      -- сокращаем исходную строку на
      -- размер полученного значения
      -- и разделителя
      SET @InputStr = SUBSTRING(@InputStr, @pos+1, LEN(@InputStr))
      -- определяем позицию след. разделителя
      SET @pos = CHARINDEX(@Delimeter, @InputStr)
  END

  INSERT INTO @table_res (val) 
  SELECT RTRIM(LTRIM(@InputStr))

  RETURN
END

/*

DECLARE @InputStr   nvarchar(max) = '0770395, 4444444, 5555555, 6666666, 7777777, 8888888, 9999999, 111111, 222222',
        @Delimiter  nvarchar(5) = ','

SELECT val
FROM master.dbo.ParsingStr(@InputStr, @Delimiter)


*/
GO