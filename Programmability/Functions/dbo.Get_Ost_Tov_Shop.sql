SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-02-27
-- Description:	Получение остатка товара по магазинам
-- =============================================
CREATE FUNCTION [dbo].[Get_Ost_Tov_Shop]
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
	select tdo.id_tov, tdo.ShopNo_rep , tdo.Ost_kon + isnull(d.Quantity_RO,0), tdo.wrong_ost podozrit_ost
			from vv03..td_ost_vw as tdo 
			   left join   vv03..Postavka_CurDay as d with(nolock) 
			     on tdo.shopNo_rep=d.ShopNo 
					and tdo.id_tov=d.id_tov
					and d.Quantity_TD=0 
				    and d.Quantity_RO <>0 
			where tdo.id_tov=@id_tov 
				
	
end
else
begin
	insert into @res (id_tov,ShopNo,qty,podozrit_ost)
	select tdo.id_tov, tdo.ShopNo_rep , tdo.Ost_kon + isnull(d.Quantity_RO,0), tdo.wrong_ost podozrit_ost
			from vv03..td_ost_vw as tdo 
			   left join   vv03..Postavka_CurDay as d with(nolock) 
			     on tdo.shopNo_rep=d.ShopNo 
					and tdo.id_tov=d.id_tov
					and d.Quantity_TD=0 
				    and d.Quantity_RO <>0 
			where tdo.id_tov=@id_tov 
				and tdo.ShopNo_rep=@Shopno

	
end
	RETURN 
END
GO