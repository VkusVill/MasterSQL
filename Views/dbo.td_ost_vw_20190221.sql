SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO






 
CREATE view [dbo].[td_ost_vw_20190221]  
as
select td.*
	, w.q
	, case when isnull(q,0)=-99999 
		then ' <i>Определение точного количества остатков этого товара в магазине затруднено. Информация по наличию может быть некорректна.</i>' 
		else '' end descr_ost
	, isnull(case when isnull(q,0)=-99999 then 1 else 0 end,0) wrong_ost
from  vv03..TD_ost as td with(nolock) 
	    inner join telegram..OST_for_WEB_BOT as w with(nolock)
	      on td.ShopNo_rep=w.ShopNo and td.id_tov=w.id_tov 






GO