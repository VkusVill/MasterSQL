SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE VIEW [dbo].[tovari_ostatki]
AS
SELECT     t.id_tov,case when (t.CatAssStr = 'Новинки') then 1 else 0 end novinka
			, case when id_group in (select id_group from vv03..[Group_tovari] where id_parent=10201) then 1 else 0 end non_food
FROM         vv03.dbo.Tovari AS t  WITH (nolock) INNER JOIN
                      vv03.dbo.TD_ost AS td WITH (nolock) ON td.id_tov = t.id_tov

GROUP BY t.id_tov,t.CatAssStr, t.id_group
HAVING      (SUM(td.Ost_kon - ISNULL(td.is_wrong_ost, 0)) > 10) AND (COUNT(DISTINCT td.ShopNo_rep) > 100)


GO