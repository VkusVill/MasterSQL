SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO









 
CREATE view [dbo].[td_ost_for_WEB_vw]  
as
select td.id_tov
	, td.Ost_kon
	, td.date_last_upd
	, td.ShopNo_rep ShopNo
	, td.is_wrong_ost  wrong_ost
	, td.id_kontr_last_post
	, case when td.is_wrong_ost =1
		  then ' <i>Определение точного количества остатков этого товара в магазине затруднено. Информация по наличию может быть некорректна.</i>' 		  else '' end descr_ost
from  vv03..TD_ost as td with(nolock) 
where td.load_web =1

GO