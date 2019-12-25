SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[parsing_select]
(
  @InputStr nvarchar(max),
  @InputStr2 nvarchar(max),
  @Delimeter nvarchar(5)
)
RETURNS nvarchar(max)
AS
BEGIN

-- передать пустой параметр @InputStr нельзя
Declare @S nvarchar(max) = '' , @i int =1

  -- определяем позицию первого разделителя
  DECLARE @pos int , @pos2 int
  DECLARE @val nvarchar(100) , @val2 nvarchar(100)


if @InputStr2 is null
begin

      Set @pos = CHARINDEX(@Delimeter, @InputStr)

      SET @val = SUBSTRING(@InputStr, 1, case @pos when 0 then 100 else @pos end-1)
      Select @s =  rtrim(@s) + ' select ' + RTRIM(LTRIM(@val)) + ' val , ' + rtrim(@i) + ' id '

      
  -- со второй
      
  WHILE (@pos != 0)
  BEGIN      
     Set @i = @i+1
      Select @InputStr = SUBSTRING(@InputStr, @pos+1, LEN(@InputStr))
      -- определяем позицию след. разделителя
      SET @pos = CHARINDEX(@Delimeter, @InputStr)
      
      SET @val = SUBSTRING(@InputStr, 1, case @pos when 0 then 100 else @pos end -1)
      Select @s =  rtrim(@s) + case when RTRIM(LTRIM(@val))<>''
								then ' union select ' + RTRIM(LTRIM(@val)) + ' , ' +  rtrim(@i)
								else '' end 	

      
  END

end
else
begin

      Set @pos = CHARINDEX(@Delimeter, @InputStr)
      Set @pos2 = CHARINDEX(@Delimeter, @InputStr2)


      SET @val = SUBSTRING(@InputStr, 1, case @pos when 0 then 100 else @pos end-1)
      SET @val2 = SUBSTRING(@InputStr2, 1, case @pos2 when 0 then 100 else @pos2 end-1)      
      Select @s =  rtrim(@s) + ' select ' + RTRIM(LTRIM(@val)) + ' val , ' + RTRIM(LTRIM(@val2)) + ' val2 , ' + rtrim(@i) + ' id '

      
  -- со второй
      
  WHILE (@pos != 0)
  BEGIN      
     Set @i = @i+1
      Select @InputStr = SUBSTRING(@InputStr, @pos+1, LEN(@InputStr))
      Select @InputStr2 = SUBSTRING(@InputStr2, @pos2+1, LEN(@InputStr2))
      -- определяем позицию след. разделителя
      SET @pos = CHARINDEX(@Delimeter, @InputStr)
      Set @pos2 = CHARINDEX(@Delimeter, @InputStr2)
      
      SET @val = SUBSTRING(@InputStr, 1, case @pos when 0 then 100 else @pos end -1)
      SET @val2 = SUBSTRING(@InputStr2, 1, case @pos when 0 then 100 else @pos2 end-1)          
      Select @s =  rtrim(@s) + ' union select ' + RTRIM(LTRIM(@val)) + ' , ' + RTRIM(LTRIM(@val2)) + ' , ' +  rtrim(@i) 

      
  END
  
  



end



 Select @s = rtrim(@s) + ' order by id '




  RETURN @s



END
GO