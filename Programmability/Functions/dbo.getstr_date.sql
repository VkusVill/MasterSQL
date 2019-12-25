SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getstr_date]
(
@date date
)
RETURNS char(5)
AS
BEGIN


return case when datepart(day,@date) < 10 then '0' else '' end +
      rtrim(datepart(day,@date)) + '.' + 
      case when datepart(month,@date) < 10 then '0' else '' end +
      rtrim(datepart(month,@date))


END
GO