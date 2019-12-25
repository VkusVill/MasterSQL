SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-05-03
-- Description:	Усечение списка товаров/тт до нужной длины
-- =============================================
CREATE FUNCTION [dbo].[Get_list_str_len]
(
	@str as varchar(max)
	,@len as int=0
)
RETURNS varchar(max)
AS
BEGIN
   set @str=ltrim(rtrim(isnull(@str,'')))
   if @len=0 
	set @len=len(@str)
   
   if len(@str)>@len and len(@str)>5
   begin
			if substring(@str,@len+1,1)<>','  
			begin
			  select @str =substring(@str,1,@len)
			  select @str=REVERSE(@str)
			  select @str=substring(@str, charindex(',',@str,1)+1, @len)
			  select @str=REVERSE(@str)	
			end
			else
			begin
				select @str =substring(@str,1,@len)
			end
	end
	else
	begin
	 if substring(@str,len(@str),1)=','
	   set @str=substring(@str,1,len(@str)-1)
	end			
			RETURN @str

END
GO