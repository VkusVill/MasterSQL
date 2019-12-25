SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[SPLIT_id_tov_order] ( @tovari_line_str VARCHAR(MAX), @delimiter varchar(1) )
RETURNS
 @returnList TABLE ([id_tov] int,rn int)

AS

BEGIN
 
 

 DECLARE @name NVARCHAR(255), @rn int =0

 DECLARE @pos INT

 WHILE CHARINDEX(@delimiter, @tovari_line_str) > 0

 BEGIN

  SELECT @pos  = CHARINDEX(@delimiter, @tovari_line_str) 

  SELECT @name = SUBSTRING(@tovari_line_str, 1, @pos-1)

   set @rn=@rn+1 
   INSERT INTO @returnList(id_tov, rn)

   SELECT @name, @rn

  SELECT @tovari_line_str = SUBSTRING(@tovari_line_str, @pos+1, LEN(@tovari_line_str)-@pos)

 END
  
 set @rn=@rn+1 
 INSERT INTO @returnList(id_tov, rn)

 SELECT @tovari_line_str, @rn

 RETURN

END
GO