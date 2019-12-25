SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO



CREATE view [dbo].[td_ost_for_abon_vw]  
as
select td.id_tov
    ,td.Ost_kon
    ,td.date_last_upd
    ,td.ShopNo_rep
    ,td.row_uid
    ,td.id_kontr_last_post 
    ,isnull(td.is_wrong_ost,0) is_wrong_ost
    ,td.date_last_post 
	,td.Ost_kon q
	,case when is_wrong_ost =1 
		then ' <i>Определение точного количества остатков этого товара в магазине затруднено. Информация по наличию может быть некорректна.</i>' 
		else '' end descr_ost
	, is_wrong_ost wrong_ost
from vv03..TD_ost as td with(nolock) 

/*
select td.id_tov
    ,td.Ost_kon
    ,td.date_last_upd
    ,td.ShopNo_rep
    ,td.row_uid
    ,td.id_kontr_last_post 
    ,td.is_wrong_ost
    ,td.date_last_post 
	,td.Ost_kon q
	,case when is_wrong_ost =1 
		then ' <i>Определение точного количества остатков этого товара в магазине затруднено. Информация по наличию может быть некорректна.</i>' 
		else '' end descr_ost
	, is_wrong_ost wrong_ost
from  vv03..TD_ost as td with(nolock) 
    inner join vv03..tt with(nolock)
		On tt.N=td.ShopNo_rep
	inner join vv03..Tovari as tov with(nolock)
	    ON 	td.id_tov=tov.id_tov 
where tt.Статус='Открыт'
	AND tov.IsComplect=0	    
	  
*/

GO