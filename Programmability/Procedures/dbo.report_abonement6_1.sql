SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[report_abonement6_1]
AS
BEGIN
  SET NOCOUNT ON

  CREATE TABLE #ch
  (
    date_ch        date,
    всего_карт     int,
    всего_телеграм int
  )

  INSERT INTO #ch
  EXEC ('
select convert(date,ch.CloseDate) date_ch,
count( distinct ch.BONUSCARD) всего_карт,
count( distinct case when  c.telegram_id is not null then ch.BONUSCARD end) всего_телеграм
from SMS_UNION..Checks (nolock) ch
inner join Loyalty..Customer c (nolock) on c.BC_Number=ch.BONUSCARD
where ch.CloseDate between DATEADD(day,-7,convert(date,getdate())) and  DATEADD(day,0,convert(date,getdate()))
group by convert(date,ch.CloseDate)
'      )
  AT [SRV-SQL01]

  CREATE TABLE #chl
  (
    date_ch   date,
    BonusCard varchar(50),
    id_tov    int
  )

  INSERT INTO #chl
  EXEC ('
select  chl.date_ch ,chl.BonusCard_cl , chl.id_tov_cl
from SMS_UNION..CheckLine chl (nolock)
where chl.date_ch > = dateadd(day,-7,CONVERT(date,getdate()))
and chl.id_discount_chl=12 and chl.OperationType_cl=1
'      )
  AT [SRV-SQL01]

  CREATE TABLE #aca
  (
    BonusCard varchar(50),
    date_sp   date,
    Lag2      int
  )

  INSERT INTO #aca
  SELECT
    *
  FROM Loyalty.dbo.Active_Cust_Ab1

  IF OBJECT_ID('Reportsreport_abonement6_1') IS NOT NULL
    DROP TABLE Reportsreport_abonement6_1

  SELECT
    b.date_activation,
    d.всего_карт,
    d.всего_телеграм,
    b.Нажали,
    b.Купили,
    b.[%Всего],
    b.ВМагНажали,
    b.КупилвМаг,
    b.[%КупВМаг],
    b.rn
  INTO
    Reportsreport_abonement6_1
  FROM
  (
    SELECT
      ct.date_activation,
      COUNT(DISTINCT ct.number) Нажали,
      COUNT(DISTINCT chl.BonusCard) Купили,
      CONVERT(int, 100.0 * COUNT(DISTINCT chl.BonusCard) / COUNT(DISTINCT ct.number)) [%Всего],
      COUNT(DISTINCT CASE WHEN act.BonusCard IS NOT NULL THEN ct.number END) ВМагНажали,
      COUNT(DISTINCT CASE WHEN act.BonusCard IS NOT NULL THEN chl.BonusCard END) КупилвМаг,
      CONVERT(
               int,
               100.0 * COUNT(DISTINCT CASE WHEN act.BonusCard IS NOT NULL THEN chl.BonusCard END)
               / COUNT(DISTINCT CASE WHEN act.BonusCard IS NOT NULL THEN ct.number END)
             ) [%КупВМаг],
      ROW_NUMBER() OVER (ORDER BY ct.date_activation) rn
    FROM vv03.dbo.coupons_type2_card_tov (NOLOCK) ct
    LEFT JOIN #aca act
      ON act.BonusCard = ct.number
         AND act.date_sp = ct.date_activation
    LEFT JOIN #chl chl
      ON ct.number = chl.BonusCard
         AND ct.id_tov = chl.id_tov
         AND ct.date_activation = chl.date_ch
    WHERE ct.type_number = 6
          AND ct.date_activation >= DATEADD(DAY, -7, CONVERT(date, GETDATE()))
          AND ct.date_activation < DATEADD(DAY, 0, CONVERT(date, GETDATE()))
    --and datepart(hour,ct.date_add) between 7 and 22
    GROUP BY ct.date_activation
  ) b
  INNER JOIN #ch d
    ON d.date_ch = b.date_activation
END
GO