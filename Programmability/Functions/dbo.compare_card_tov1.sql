SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[compare_card_tov1]
(
	-- Add the parameters for the function here
	@str1 nvarchar(max),
	@str2 as nvarchar(max)
)
RETURNS int
AS
BEGIN

--declare @str1 nvarchar(max)
declare @q int 
select @q= 100.0* COUNT(b.id_tov ) / COUNT(*) 
from 
(select N.X.value('text()[1]','int') id_tov
 from
(SELECT Convert(XML,'<s>' + replace(@str1,',','</s><s>') + '</s>'))S(X) 
  CROSS APPLY S.X.nodes('/s') N(X)
)a
left join 
(select N.X.value('text()[1]','int') id_tov
 from
(SELECT Convert(XML,'<s>' + replace(@str2,',','</s><s>') + '</s>'))S(X) 
  CROSS APPLY S.X.nodes('/s') N(X)
  )  b on a.id_tov = b.id_tov
return @q

END
GO