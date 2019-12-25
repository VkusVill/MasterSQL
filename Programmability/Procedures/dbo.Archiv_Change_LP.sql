SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-04-07
-- Description: :Журнал изменения ЛП
-- =============================================

CREATE PROCEDURE [dbo].[Archiv_Change_LP] @bonusCard AS char(7)
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

  IF OBJECT_ID('tempdb..#lt') IS NOT NULL
    DROP TABLE #lt

  IF OBJECT_ID('tempdb..#arc') IS NOT NULL
    DROP TABLE #arc

  IF OBJECT_ID('tempdb..#r') IS NOT NULL
    DROP TABLE #r

  IF OBJECT_ID('tempdb..#Cashier') IS NOT NULL
    DROP TABLE #Cashier

  IF OBJECT_ID('tempdb..#res') IS NOT NULL
    DROP TABLE #res

  CREATE TABLE #Cashier
  (
    Кассир varchar(200),
    date_ch datetime
  )

  DECLARE @s AS nvarchar(4000)

  SET @s = N'exec(''
select cashier.FIO, ch.closedate
 from SMS_UNION.dbo.checks as ch with(nolock) 
		 left join  [SMS_REPL].[dbo].[Cashier_view_tbl]  as cashier with(nolock) on ch.CashierID=cashier.CodeFL
where ch.CloseDate>=CONVERT(date,dateadd(day,-8,getdate()))	and ch.BONUSCARD=''''' + @bonusCard
           + N'''''  '') at [srv-sql01]'

  INSERT INTO #Cashier (
    Кассир,
    date_ch
  )
  EXEC sp_executesql @s

  SELECT
    tov.Name_tov товар,
    lct.id_tov,
    lct.date_from,
    lct.date_to,
    lct.sp_price,
    lct.date_add,
    lct.id,
    NULL date_ins,
    CASE
      WHEN ISNULL(st.id, 0) = 0 THEN
        RTRIM(lct.Set_Type)
      ELSE
        st.NameType
    END set_type,
    ROW_NUMBER() OVER (ORDER BY lct.id DESC) rn,
    1 rk
  INTO
    #lt
  FROM vv03.[dbo].[lovepr_card_tov] AS lct WITH (NOLOCK)
  INNER JOIN vv03..Tovari AS tov WITH (NOLOCK)
    ON lct.id_tov = tov.id_tov
  LEFT JOIN vv03..Set_Type_LP AS st WITH (NOLOCK)
    ON lct.Set_Type = st.id
  WHERE lct.number = @bonusCard
  ORDER BY date_to DESC

  SELECT
    tov.Name_tov,
    lct.id_tov,
    lct.date_from,
    lct.date_to,
    lct.sp_price,
    lct.date_add,
    lct.id,
    date_ins,
    CASE
      WHEN ISNULL(st.id, 0) = 0 THEN
        RTRIM(lct.set_type)
      ELSE
        st.NameType
    END set_type,
    0 rn,
    1 + ROW_NUMBER() OVER (PARTITION BY lct.id ORDER BY date_ins DESC) rk
  INTO
    #arc
  FROM vv03.[dbo].[arc_lovepr_card_tov] AS lct WITH (NOLOCK)
  INNER JOIN vv03..Tovari AS tov WITH (NOLOCK)
    ON lct.id_tov = tov.id_tov
  LEFT JOIN vv03..Set_Type_LP AS st WITH (NOLOCK)
    ON lct.set_type = st.id
  WHERE lct.number = @bonusCard

  UPDATE
    #arc
  SET
    rn = l.rn
  FROM #arc AS a
  INNER JOIN #lt AS l WITH (NOLOCK)
    ON a.id = l.id

  SELECT
    *
  INTO
    #r
  FROM
  (SELECT * FROM #lt UNION ALL SELECT * FROM #arc) a
  ORDER BY id DESC,
           rn,
           rk

  SELECT
    r1.id_tov,
    r1.date_add [Дата Создания ЛП], -- CONVERT(varchar(200), null)Кассир,
    r1.id,
    r1.товар,
    r1.date_from [ДатаС до Измен],
    r1.date_to [ДатаПо до Измен],
    r1.set_type [СпУстан до Измен],
    r1.date_ins [Дата Изменений],
    r2.date_from [ДатаС после Измен],
    r2.date_to [ДатаПо после Измен],
    r2.set_type [СпУстан после Измен],
    CASE
      WHEN r1.sp_price <> r2.sp_price THEN
        'Изменение цены ' + RTRIM(r1.sp_price) + ' на ' + RTRIM(r2.sp_price)
      ELSE
        ''
    END + CASE
            WHEN r1.id_tov <> r2.id_tov THEN
              ' Изменение ЛП ' + r1.товар + ' на ' + r2.товар
            ELSE
              ''
          END Коммент,
    ROW_NUMBER() OVER (ORDER BY r1.id DESC, r1.rn, r1.rk) rn,
    0 cn
  INTO
    #res
  FROM #r r1
  LEFT JOIN #r r2
    ON r1.id = r2.id
       AND r1.rk - 1 = r2.rk

  --order by r1.ID desc,  r1.rn, r1.rk
  UPDATE
    #res
  SET
    cn = 1
  FROM #res AS r
  INNER JOIN
  (SELECT id FROM #res GROUP BY id HAVING COUNT(*) = 1) AS gr
    ON r.id = gr.id

  SELECT
    a.[Дата Создания ЛП],
    a.id,
    a.товар,
    a.[ДатаС до Измен],
    a.[ДатаПо до Измен],
    a.[СпУстан до Измен],
    a.[Дата Изменений],
    a.[ДатаС после Измен],
    a.[ДатаПо после Измен],
    a.[СпУстан после Измен],
    a.Коммент,
    a.Кассир,
    a.rn
  FROM
  (
    SELECT
      *,
      ROW_NUMBER() OVER (PARTITION BY r.rn ORDER BY c.date_ch DESC) rr
    FROM #res AS r
    LEFT JOIN #Cashier AS c WITH (NOLOCK)
      ON ISNULL( r.[Дата Изменений],
                 (CASE
                    WHEN cn = 1 THEN
                      r.[Дата Создания ЛП]
                    ELSE
                      DATEADD(DAY, +1, GETDATE())
                  END
                 )
               ) BETWEEN DATEADD(MINUTE, -5, c.date_ch) AND DATEADD(MINUTE, 5, c.date_ch)
  ) a
  WHERE rr = 1
  ORDER BY rn

  IF OBJECT_ID('tempdb..#lt') IS NOT NULL
    DROP TABLE #lt

  IF OBJECT_ID('tempdb..#arc') IS NOT NULL
    DROP TABLE #arc

  IF OBJECT_ID('tempdb..#r') IS NOT NULL
    DROP TABLE #r

  IF OBJECT_ID('tempdb..#Cashier') IS NOT NULL
    DROP TABLE #Cashier

  IF OBJECT_ID('tempdb..#res') IS NOT NULL
    DROP TABLE #res
END
GO