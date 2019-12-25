SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[del_summ_dates_tt]
(
@date_start date,
@date2 date ,
@id_tt int
)
RETURNS @table table  (date_tt date,Basesum int)
AS
BEGIN



insert into @table
SELECT    date_tt, convert(int,c.Basesum /*- ISNULL(a.Dost, 0)*/) AS Basesum
FROM         (SELECT      date_tt, SUM(summa) AS Basesum
              FROM          vv03.dbo.DTT WITH (nolock, index(ind1))
              WHERE      date_tt  between @date_start and @date2 and id_tt=@id_tt
              GROUP BY  date_tt) AS c 

return 

END
GO