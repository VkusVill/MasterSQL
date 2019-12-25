SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-02-27
-- Description:	Получение остатка товара по магазинам
-- =============================================
CREATE FUNCTION [dbo].[Get_Ost_Tov_Shop_20190611]
(	
@id_tov int,
@Shopno int =0
)
RETURNS 
@res TABLE 
(
id_tov int,
ShopNo int,
Qty decimal(15,3),
podozrit_ost bit
)
AS
BEGIN
if @ShopNo=0
begin
	insert into @res (id_tov,ShopNo,qty,podozrit_ost)
	select id_tov, ShopNo, SUM(Ost_kon)+ case when SUM(postTT)=0 then SUM(postSklad) else 0 end qty, MAX(podozrit_ost)
	from (	select id_tov, Ost_kon,ShopNo_rep ShopNo, 0 postTT, 0 postSklad, tdo.wrong_ost podozrit_ost
			from vv03..td_ost_vw as tdo 
			where id_tov=@id_tov-- and Ost_kon>0
			union all
			select d.id_tov, 0,ShopNo , Quantity_TD, Quantity_RO postSklad,0
			from vv03..Postavka_CurDay as d with(nolock) 
				inner join vv03..tt  as tt with(nolock) on d.id_tt=tt.id_tt
			where d.id_tov=@id_tov and tt.tt_format=2
	) a
	group by id_tov, ShopNo
	--having (SUM(Ost_kon)+ case when SUM(postTT)=0 then SUM(postSklad) else 0 end) >0	
end
else
begin
	insert into @res (id_tov,ShopNo,qty,podozrit_ost)
	select id_tov, ShopNo, SUM(Ost_kon)+ case when SUM(postTT)=0 then SUM(postSklad) else 0 end qty, MAX(podozrit_ost)
	from (	select id_tov, Ost_kon,ShopNo_rep ShopNo, 0 postTT, 0 postSklad, case when isnull(q,0)=-99999 then 1 else 0 end podozrit_ost
			from vv03..td_ost_vw as tdo 
			where id_tov=@id_tov and shopNo_Rep=@ShopNo-- and Ost_kon>0
			union all
			select d.id_tov, 0,ShopNo , Quantity_TD, Quantity_RO postSklad,0
			from vv03..Postavka_CurDay as d with(nolock) 
				inner join vv03..tt  as tt with(nolock) on d.id_tt=tt.id_tt
			where d.id_tov=@id_tov and tt.tt_format=2 and d.ShopNo=@Shopno

	) a
	group by id_tov, ShopNo
	--having (SUM(Ost_kon)+ case when SUM(postTT)=0 then SUM(postSklad) else 0 end) >0	
end
	RETURN 
END
GO