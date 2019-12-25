SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2019-02-28
-- Description:	Получение  последовательности , состоящей из уникальных элементов, из 2 строк
-- =============================================
CREATE FUNCTION  [dbo].[UNION_Str_unique](
         @str1 varchar(max)
		,@str2 varchar(max)
		,@Delimeter varchar(5)
)
RETURNS varchar(max)
AS
BEGIN
   DECLARE @InputStr varchar(max)		
   
   SET @str1=ISNULL(RTRIM(LTRIM(@str1)),'')	
   SET @str2=ISNULL(RTRIM(LTRIM(@str2)),'')
   
   IF @str1=''
     RETURN @str2

   IF ISNULL(RTRIM(LTRIM(@str2)),'')=''
     RETURN @str1

   SET @InputStr=@str1+@Delimeter + @str2



 
   
  -- создаем переменную для хранения  
  DECLARE @val nvarchar(100)
  DECLARE @table_res table(val int,
							INDEX IX_TableVar NONCLUSTERED (val)) 
  
  
  -- определяем позицию первого разделителя
  DECLARE @pos int = CHARINDEX(@Delimeter, @InputStr) 
  
  
  
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

  --RETURN @InputStr
  INSERT INTO @table_res (val) 
  SELECT RTRIM(LTRIM(@InputStr))
  
        
  SELECT @InputStr = SUBSTRING((SELECT 
          ',' + RTRIM(val)
        FROM (SELECT distinct val  FROM @table_res ) a
        FOR xml PATH ('') )
        , 2, 2000)
        
  
	RETURN @InputStr        

END
GO