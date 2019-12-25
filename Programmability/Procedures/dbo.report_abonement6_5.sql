SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[report_abonement6_5]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


if OBJECT_ID ('Reportsreport_abonement6_5') is not null drop table Reportsreport_abonement6_5


select a.Name_tov , a.k , СколькоРаз, convert(int,a.сумма)Сумма
, ROW_NUMBER () over (order by convert(int,a.сумма) desc) rn
into Reportsreport_abonement6_5
from
( 
SELECT 
      datepart(day,[date_add]) день,
      [k]
      , t.Name_tov
      , SUM(q*t.price_tov) сумма
      , COUNT(*) СколькоРаз
      , ROW_NUMBER() over (partition by datepart(day,[date_add]) , [k] order by SUM(q*t.price_tov) desc)      rn
  FROM [vv03].[dbo].[archive_ost_shopno_abonement1] ar (nolock)
  inner join vv03..Tovari t  (nolock) on t.id_tov = ar.id_tov
  where datepart(hour,[date_add])=datepart(hour,GETDATE())
    and ar.date_add > dateadd(day,0,CONVERT(date,getdate()))
    and k=2
  group by  datepart(day,[date_add]) ,
      [k]  ,
      t.Name_tov
      ) a
where a.rn <=20     





END
GO