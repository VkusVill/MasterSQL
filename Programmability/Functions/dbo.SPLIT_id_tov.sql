SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[SPLIT_id_tov] ( @tovari_line_str VARCHAR(MAX), @delimiter varchar(1) )
RETURNS
 @returnList TABLE ([id_tov] int)

AS

BEGIN

 DECLARE @name NVARCHAR(255)

 DECLARE @pos INT

 WHILE CHARINDEX(@delimiter, @tovari_line_str) > 0

 BEGIN

  SELECT @pos  = CHARINDEX(@delimiter, @tovari_line_str) 

  SELECT @name = SUBSTRING(@tovari_line_str, 1, @pos-1)

  INSERT INTO @returnList

  SELECT @name
  SELECT @tovari_line_str = SUBSTRING(@tovari_line_str, @pos+1, LEN(@tovari_line_str)-@pos)

 END

 INSERT INTO @returnList

 SELECT @tovari_line_str

 RETURN

END
GO