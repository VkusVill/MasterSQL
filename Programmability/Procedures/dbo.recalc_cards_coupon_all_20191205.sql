SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		АК
-- Create date: 
-- Description:	пересчет таблицы vv03..Cards_coupon, данные о скидках покупателя для кассы
-- Change:      OD -добавление скидок на полные аналоги
-- =============================================
CREATE PROCEDURE [dbo].[recalc_cards_coupon_all_20191205] 
	-- Add the parameters for the stored procedure here
@id_job as int=-1000
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @job_name as varchar(100)=com.dbo.Object_name_for_err(@@procid,db_id())

create table #Tovari (id_tov int, Name_tov varchar(150))

insert into #tovari(id_tov,Name_tov)
select id_tov,name_tov from vv03.dbo.Tovari with(nolock)

if not exists(select * from #tovari)
begin
	begin try
		delete from #tovari
		insert into #tovari(id_tov, Name_tov)
		select * from openquery([srv-sql01],'select id_tov, name_tov from m2.dbo.Tovari')
	end try
	begin catch
		insert into jobs..error_jobs (job_name , message , number_step , id_job)
		select @job_name , ERROR_MESSAGE() , 1 , @Id_job
	end catch
end

create table #toFr (id_tov int 
		, number char(7) 
		, coup int 
		, price int 
		, date_activation date
		, date_from date 
		, date_to date 
		, LovePr_today int
		, LovePr_tomor int 
		, Date_LovePr_to date 
		, proc_sk_ab int 
		, proc_sk_lt int
		, name_tov nvarchar(150) 
		,[id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY)


declare  @date_start_recalc_after as datetime =getdate()

insert into #toFr
select a.id_tov 
	, a.number
	, MAX(a.coup) coup 
	, MAX(price) price 
	, MAX(date_activation) 
	, MAX(date_from) 
	, MAX(date_to) 
	, MAX(a.LovePr_today) 
	, MAX(a.LovePr_tomor) 
	, MAX(Date_LovePr_to) 
	, MIN (a.proc_sk_ab) 
	, MIN (a.proc_sk_lt)
	, t.Name_tov
from
		(
		select ct.number ,ct.id_tov , ct.sp_price coup, 0 price , ct.date_activation , ct.date_from , ct.date_to
		, 0 LovePr_today , 0 LovePr_tomor , null Date_LovePr_to , ct.proc_sk proc_sk_ab, null proc_sk_lt
		FROM vv03..coupons_type2_card_tov as ct with(nolock)
		where ct.date_from > CONVERT(date,GETDATE())

		union all

		select ct.number, ct.id_tov , 0 ,ct.sp_price , null , null , MAX(ct.date_to), 0 ,0 , null , min(ct.proc_sk) , null
		FROM vv03..coupons_type2_card_tov as ct with(nolock)
		where CONVERT(date,GETDATE()) between ct.date_from and ct.date_to 
		   and ct.date_take is not null
		group by ct.number, ct.id_tov  ,ct.sp_price

		union all

		-- на сегодня. если нет на завтра, то proc_sk из завтра
		select lct.number , lct.id_tov , 0 , 0, null , null, null, lct.sp_price , 0 , lct.date_to , null , lct.proc_sk
		from vv03.[dbo].[lovepr_card_tov] as lct with(nolock) 
		where lct.date_to >= CONVERT(date,getdate()) and date_from <= CONVERT(date,getdate())

		union all

		-- на завтра
		select lct.number , lct.id_tov , 0 , 0, null , null, null, 0, lct.sp_price , lct.date_to, null , lct.proc_sk
		from [vv03].[dbo].[lovepr_card_tov]  as lct with(nolock) 
		where lct.date_to > CONVERT(date,getdate()) and lct.date_from <= dateadd(day,1,CONVERT(date,getdate()))

		) a
	inner join #Tovari t on t.id_tov = a.id_tov
group by a.id_tov , a.number , t.Name_tov

--добавим полные аналоги
INSERT INTO #toFr (id_tov,number,coup,price,date_activation,date_FROM,date_to
					,LovePr_today, LovePr_tomor, Date_LovePr_to,proc_sk_ab, proc_sk_lt, name_tov)
SELECT ta.id_tov2
		,t.number
		,CASE WHEN t.coup=0 THEN 0 ELSE CEILING(1.0 * pr.Price *  (1.0 - 1.0 * t.proc_sk_ab / 100) ) END 
		,CASE WHEN t.price=0 THEN 0 ELSE CEILING(1.0 * pr.Price *  (1.0 - 1.0 * t.proc_sk_ab / 100) ) END
		,t.date_activation
		,t.date_FROM
		,t.date_to
		,CASE WHEN t.LovePr_today=0 THEN 0 ELSE FLOOR(1.0 * pr.Price *  (1.0 - 1.0 * t.proc_sk_lt  / 100) ) END
		,CASE WHEN t.LovePr_tomor=0 THEN 0 ELSE FLOOR(1.0 * pr.Price *  (1.0 - 1.0 * t.proc_sk_lt / 100) ) END
		,t.Date_LovePr_to
		,t.proc_sk_ab
		,t.proc_sk_lt 
		,ta.Name_tov2  
		--select *
FROM #toFr t with(nolock)
  INNER JOIN vv03..Tovar_full_analog as ta with(nolock)
	on t.id_tov=ta.id_tov1
  INNER JOIN vv03..Price_1C_tov as pr WITH(NOLOCK)
    ON ta.id_tov2=pr.id_tov
  LEFT JOIN #toFr as ex with(nolock)
    ON ex.number=t.number
		AND ex.id_tov=ta.id_tov2 
WHERE (t.price <> 0 OR t.LovePr_today<>0) 
		AND ex.id_tov is null      
ORDER BY t.number    


create index ind1 on #toFr (number) include  (name_tov)

create table #a (number char(7) 
		, id_tov nvarchar(max) 
		, price nvarchar(max) 
		, coup nvarchar(max) 
		, LovePr_today nvarchar(max) 
		, LovePr_tomor nvarchar(max) 
		, date_from date 
		, date_to date 
		, proc_sk_ab int 
		, Date_LovePr_to date 
		, proc_sk_lt int
		, [id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY)


insert into #a
select a.number 
, substring(convert(nvarchar(max),a.id_tov),2,4000) id_tov
, substring(convert(nvarchar(max),a.price),2,4000) price
, substring(convert(nvarchar(max),a.coup),2,4000) coup
, substring(convert(nvarchar(max),a.LovePr_today),2,4000) LovePr_today
, substring(convert(nvarchar(max),a.LovePr_tomor),2,4000) LovePr_tomor
, tf.date_from
, tf.date_to
, tf.proc_sk_ab
, tf2.Date_LovePr_to 
, tf2.proc_sk_lt
from
		(SELECT 
		  number, 
		  ((
			SELECT ',' + rtrim(tf.[id_tov] )
			FROM #toFr tf
			WHERE (number = Results.number ) 
			order by [name_tov]
			FOR XML PATH(''),TYPE) ) AS id_tov ,
		((
			SELECT ',' + rtrim(tf.[price] )
			FROM #toFr tf
			WHERE (number = Results.number ) 
			order by [name_tov]
			FOR XML PATH(''),TYPE) ) AS price ,
			  ((
			SELECT ',' + rtrim([coup] )
			FROM #toFr tf
			WHERE (number = Results.number ) 
			order by [name_tov]
			FOR XML PATH(''),TYPE) ) AS coup ,
		  ((
			SELECT ',' + rtrim([LovePr_today] )
			FROM #toFr tf
			WHERE (number = Results.number ) 
			order by [name_tov]
			FOR XML PATH(''),TYPE) ) AS LovePr_today ,
		  ((
			SELECT ',' + rtrim([LovePr_tomor] )
			FROM #toFr tf
			WHERE (number = Results.number ) 
			order by [name_tov]
			FOR XML PATH(''),TYPE) ) AS  LovePr_tomor       
		FROM #toFr Results
		GROUP BY number
		) a
	left join  (select distinct number , date_from , date_to , proc_sk_ab 
				from #toFr tf 
				where date_to is not null) tf on a.number = tf.number  
	inner join (select number , max(Date_LovePr_to) Date_LovePr_to , MAX(proc_sk_lt) proc_sk_lt 
				from #toFr tf 
				group by number
				) tf2 on a.number = tf2.number

create index ind1 on #a (number) 



update vv03..Cards_coupon with (rowlock)
set Tovari_str = a.id_tov
, Prices_str = a.price
, Cupon_str = a.coup
, LovePr_today_str = a.LovePr_today
, LovePr_tomor_str = a.LovePr_tomor
, Date_coup_from = a.date_from
, Date_coup_to = a.date_to
, Date_LovePr_to = a.Date_LovePr_to
, proc_sk_ab = a.proc_sk_ab
, proc_sk_lt = a.proc_sk_lt
--select *
from vv03..Cards_coupon cc 
left join  #a a on cc.Number = a.number
where 
  ( isnull(cc.Tovari_str,'') <> isnull(a.id_tov,'')
or isnull(cc.Prices_str,'') <> isnull(a.price,'')
or isnull(cc.Cupon_str,'') <> isnull(a.coup,'')
or isnull(cc.LovePr_today_str,'') <> isnull(a.LovePr_today,'')
or isnull(cc.LovePr_tomor_str,'') <> isnull(a.LovePr_tomor,'')
or isnull(cc.Date_coup_from,{d'2000-01-01'}) <> isnull(a.date_from,{d'2000-01-01'}) 
or isnull(cc.Date_coup_to,{d'2000-01-01'}) <> isnull(a.date_to,{d'2000-01-01'}) 
or isnull(cc.Date_LovePr_to,{d'2000-01-01'}) <> isnull(a.Date_LovePr_to,{d'2000-01-01'}) 
or isnull(cc.proc_sk_ab,0) <> isnull(a.proc_sk_ab,0)
or isnull(cc.proc_sk_lt,0) <> isnull(a.proc_sk_lt,0) )

drop table #a

drop table #toFr

	---пересчитаем абонементы добавленные в момент основного пересчета.

begin try
	declare  @number as char(7)

	declare crs_number cursor for

	select distinct number from vv03..coupons_type2_card_tov as c with(nolock)
	where date_add between @date_start_recalc_after and getdate()
	union 
	select distinct number from vv03..lovepr_card_tov  as c with(nolock)
	where date_add between @date_start_recalc_after and getdate()
	
	
	open crs_number

	fetch crs_number into @number

	while @@FETCH_STATUS<>-1
	begin
	 -- select @number
	 exec vv03..recalc_cards_coupon_number @number
	 fetch next from crs_number into @number

	end
	close crs_number
	deallocate crs_number
end try
begin catch
  insert into jobs..error_jobs(job_name, number_step, message, id_job)
  select @job_name, 10, ERROR_MESSAGE(),@id_job
end catch
END
GO