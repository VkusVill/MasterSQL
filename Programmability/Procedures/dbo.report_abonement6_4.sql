﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[report_abonement6_4]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

create table #chl (date_ch date,BonusCard char(7) , id_tov int)

insert into #chl
exec
('
select  chl.date_ch ,chl.BonusCard_cl , chl.id_tov_cl
from SMS_UNION..CheckLine chl (nolock)
where chl.date_ch > = dateadd(day,-7,CONVERT(date,getdate()))
and chl.id_discount_chl=12 and chl.OperationType_cl=1
') at [srv-sql01]

create table #aca (BonusCard char(7) , date_sp date,  Lag2 int)
insert into #aca
select *
from loyalty..Active_Cust_Ab1

if OBJECT_ID ('Reportsreport_abonement6_4') is not null drop table Reportsreport_abonement6_4


select b.type_tov , b.Name_tov , b.ВМагНеВыбр , a.ВМаг , a.КупВМаг , a.Доля

, ROW_NUMBER() over (order by b.type_tov, b.ВМагНеВыбр desc ) rn

into Reportsreport_abonement6_4


from(select  ct.type_tov , ct.id_tov  ,t.Name_tov , COUNT(distinct ct.number ) ВМагНеВыбр 
	,  ROW_NUMBER() over (PARTITION by ct.type_tov order by COUNT(distinct ct.number ) desc)  rn1

	from vv03..Coupons_type2_card_tov (nolock) ct
		inner join vv03..Tovari t  WITH (nolock)
			on t.id_tov = ct.id_tov
		inner join #aca act 
			on act.bonuscard = ct.number and act.date_sp = ct.date_activation
		left join #chl chl 
			on ct.number = chl.BonusCard and ct.id_tov = chl.id_tov and ct.date_activation = chl.date_ch
		left join (select distinct chl.BonusCard, chl.date_ch from #chl chl ) chl2 
			on ct.number = chl2.BonusCard and ct.date_activation = chl2.date_ch
	where ct.type_number=6
		and ct.date_activation = dateadd(day,-1,CONVERT(date,getdate())) and chl2.BonusCard is null
		and ct.par3 is null
		group by ct.id_tov , t.Name_tov, ct.type_tov
	) b
	left join(select ct.type_tov, ct.id_tov , COUNT(distinct ct.number ) ВМаг , count(distinct chl.BonusCard) КупВМаг 
			,convert(int,100.0* count(distinct chl.BonusCard) / COUNT(distinct ct.number )) Доля
		from vv03..Coupons_type2_card_tov (nolock) ct
			inner join #aca act 
				on act.bonuscard = ct.number and act.date_sp = ct.date_activation
			left join #chl chl 
				on ct.number = chl.BonusCard and ct.id_tov = chl.id_tov and ct.date_activation = chl.date_ch
			inner join	(select distinct chl.BonusCard, chl.date_ch from #chl chl ) chl2 
				on ct.number = chl2.BonusCard and ct.date_activation = chl2.date_ch

			where ct.type_number=6
				and ct.date_activation = dateadd(day,-1,CONVERT(date,getdate()))
				and ct.par3 is null
			group by ct.type_tov, ct.id_tov) a 
		on a.id_tov=b.id_tov and a.type_tov = b.type_tov
where b.rn1<=20









END
GO