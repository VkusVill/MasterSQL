SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO








 
CREATE view [dbo].[td_ost_for_WEB_vw_20190221]  
as
select td.id_tov
	, isnull(case when isnull(q,0)=-99999 then q else td.Ost_kon end,0) Ost_kon
	, td.date_last_upd
	, td.ShopNo_rep ShopNo
	, isnull(case when isnull(q,0)=-99999 then 1 else 0 end,0) wrong_ost
	, td.id_kontr_last_post
	, case when isnull(q,0)=-99999 
		  then ' <i>Определение точного количества остатков этого товара в магазине затруднено. Информация по наличию может быть некорректна.</i>' 
		  else '' end descr_ost
from  vv03..TD_ost as td with(nolock) 
	    inner join telegram..OST_for_WEB_BOT as w with(nolock)
	      on td.ShopNo_rep=w.ShopNo and td.id_tov=w.id_tov 

GO