SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[make_split_del]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


--create table vv03..split_test_tov (id_tov int , type_test int , znach int , ned_st_date date)
--create table vv03..split_test_tt (id_tt int , type_test int , znach int , ned_st_date date)

create table #tov (id int)
insert into #tov
exec 
('select t.id_tov 
from M2..tov_kontr t
group by t.id_tov
having COUNT( case when t.rasp_all_init =0 then 1 end)=0
and  COUNT( case when t.rasp_all_init =1 then 1 end)>0
') at [srv-sql01]

declare @ned_st_1 date

--select 21%4

select 
@ned_st_1 = dateadd(day, 1 - DATEPART(weekday,getdate()) ,DATEADD(week,-1,convert(date,getdate()))) -- пн прошлой недели
 

insert into vv03..split_test_tt (id_tt  , type_test  , znach  , ned_st_date) 
select DT.id_tt , 
case when (ROW_NUMBER() over ( order by sum(DT.Summa)))%5 =0 then 1 else 0 end rn ,
sum(DT.Summa),
DATEADD(day,1,convert(date,getdate()))
from vv03..DT (nolock)
where DT.Date_tt between @ned_st_1 and DATEADD(DAY,6,@ned_st_1) and DT.tt_format_dt=2
group by DT.id_tt
having count(*)=7


insert into vv03..split_test_tov (id_tov  , type_test  , znach  , ned_st_date) 
select DTt.id_tov , 
case when (ROW_NUMBER() over ( order by sum(DTt.Summa)))%5 =0 then 1 else 0 end rn ,
sum(DTt.Summa),
DATEADD(day,1,convert(date,getdate()))
from vv03..DTt (nolock)
where DTt.Date_tt between @ned_st_1 and DATEADD(DAY,6,@ned_st_1) and DTt.tt_format_dtt=2
and DTT.id_tov in (select * from #tov)
and DTt.Summa>10
group by DTt.id_tov
having count( distinct DTT.date_tt)=7


-- поменять на сплит товары с полными аналогами
update vv03..split_test_tov 
set type_test =1
from vv03..split_test_tov st
where st.type_test=0
and ( st.id_tov in (
select  tp.id_tov_Osnovn
from vv03..split_test_tov st
inner join [srv-sql01].Reports.dbo.tov_poln_zamenyaem tp on 
(tp.id_tov_Zadvoen=st.id_tov )and st.type_test=1
)
or st.id_tov in (
select tp.id_tov_Zadvoen
from vv03..split_test_tov st
inner join [srv-sql01].Reports.dbo.tov_poln_zamenyaem tp on 
(tp.id_tov_Osnovn=st.id_tov)and st.type_test=1
))


select t.Name_tov , st.type_test  , znach
from vv03..split_test_tov st
inner join vv03..tovari as t WITH (nolock) on t.id_tov=st.id_tov
order by znach


select tt.name_TT , st.type_test  , znach
from vv03..split_test_tt st
inner join vv03..tt  WITH (nolock) on tt.id_tt=st.id_tt
order by znach



END
GO