SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE view [dbo].[Reiting_reset_period_vw]
as
SELECT 
  id_tov, 
  id_kontr, 
  date_reset 
FROM (  SELECT 
          id_tov,
          isnull(id_kontr, 0) id_kontr,
          date_reset,
          date_add,
          Reason,
          Autor,
          ROW_NUMBER() OVER(PARTITION by id_tov, id_kontr ORDER BY date_reset DESC) AS rn
        FROM vv03.dbo.Reiting_reset_period
     ) AS a
WHERE a.rn = 1

GO