SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[count_tov]
(
	-- Add the parameters for the function here
	@str1 nvarchar(max)
)
RETURNS int
AS
BEGIN

--declare @str1 nvarchar(max)
declare @q int 
select @q = count(*)
 from
(SELECT Convert(XML,'<s>' + replace(@str1,',','</s><s>') + '</s>'))S(X) 
  CROSS APPLY S.X.nodes('/s') N(X)
return @q

END
GO