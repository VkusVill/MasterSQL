SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2019-03-07
-- Description:	Получение прайслиста по формату на конкретную дату
-- =============================================
CREATE FUNCTION [dbo].[price_format_date]
(	
@date as datetime 
)
RETURNS TABLE 
AS
RETURN
	--declare @date as date = getdate()+1
select a.id_tov, a.price, a.tt_format, @date date_pr
from (	select id_tov,tt_format,price, @date date_pr
			, ROW_NUMBER() over (partition by id_tov, tt_format order by date_pr desc)rn
		from vv03..Price_tov_tt_format_period as pr with(nolock)
		where  pr.date_pr <DATEADD(day,1,@date)) a
where a.rn=1
GO