SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		Андрей Кривенко
-- Create date: 
-- Description:	Пересчет данных по скидкам на карте покупателя для кассы
-- =============================================
CREATE PROCEDURE [dbo].[recalc_cards_coupon_number_20191205] 
	-- Add the parameters for the stored procedure here
@nvaCardNum char(7) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ANSI_WARNINGS On;
	SET ANSI_NULLS ON;
--declare @nvaCardNum char(7)  = '0001757'

declare @id_job  int=-1000
	,@job_name   varchar(500)=com.dbo.Object_name_for_err(@@procid,DB_id())--'recalc_cards_coupon_number'--master.dbo.Object_name_for_err(@@procid,DB_id())
	,@err_mess   varchar(max)
	,@err_num    bigint

declare @strТекстSQLЗапроса nvarchar(4000)
 
if not exists (SELECT * FROM vv03.dbo.Cards_coupon  as c WITH(NOLOCK) WHERE c.number = @nvaCardNum)
insert into vv03..Cards_coupon(number)
SELECT @nvaCardNum


create table #toFr (id_tov int 
					, number char(7) 
					, coup int 
					, price int 
					, date_activation date
					, date_FROM date 
					, date_to date 
					, LovePr_today int
					, LovePr_tomor int 
					, Date_LovePr_to date 
					, proc_sk_ab int 
					, proc_sk_lt int
					, name_tov nvarchar(150) 
					, [id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY)


declare  @err int =1 , @count int =0 


while (1=1 AND @count<5)
begin
	begin try
			truncate table #toFr
			--declare @nvaCardNum char(7)  ='0000138'-- '0212072'
			insert into #toFr
			SELECT a.id_tov , a.number
					, CASE WHEN MAX(isnull(a.coup,-10))=-10 THEN null else MAX(isnull(a.coup,0)) end coup 
					, CASE WHEN MAX(isnull(price,-10))=-10 THEN null else MAX(isnull(price,-10)) end price 
					, CASE WHEN MAX(isnull(date_activation,{d'2000-01-01'})) ={d'2000-01-01'} 
							THEN null else MAX(isnull(date_activation,{d'2000-01-01'})) end date_activation
					, CASE WHEN MAX(isnull(date_FROM,{d'2000-01-01'}))={d'2000-01-01'} 
							THEN null else MAX(isnull(date_FROM,{d'2000-01-01'})) end date_FROM 
					, CASE WHEN MAX(isnull(date_to,{d'2000-01-01'}))={d'2000-01-01'} 
							THEN null else MAX(isnull(date_to,{d'2000-01-01'})) end date_to 
					, CASE WHEN MAX(isnull(a.LovePr_today,-10))  =-10
							THEN null else MAX(isnull(a.LovePr_today,-10)) end LovePr_today
					, CASE WHEN MAX(isnull(a.LovePr_tomor,-10))=-10 
							THEN null else MAX(isnull(a.LovePr_tomor,0)) end LovePr_tomor 
					, CASE WHEN MAX(isnull(Date_LovePr_to,{d'2000-01-01'}))={d'2000-01-01'}
							THEN null else MAX(isnull(Date_LovePr_to,{d'2000-01-01'})) end  Date_LovePr_to  
					, CASE WHEN MIN (isnull(a.proc_sk_ab,9999999)) =9999999
							THEN null else MIN (isnull(a.proc_sk_ab,9999999)) end proc_sk_ab
					, CASE WHEN MIN (isnull(a.proc_sk_lt,9999999))=9999999 
							THEN null else MIN (isnull(a.proc_sk_lt,9999999)) end proc_sk_lt
			, t.Name_tov
			FROM
			(
			--БУДУЩИЙ АБОНЕМНТ
			SELECT ct.number ,ct.id_tov , ct.sp_price coup, 0 price , ct.date_activation , ct.date_FROM , ct.date_to
			, 0 LovePr_today , 0 LovePr_tomor , null Date_LovePr_to , ct.proc_sk proc_sk_ab, null proc_sk_lt
			FROM vv03.dbo.coupons_type2_card_tov as ct WITH(NOLOCK)
			WHERE  ct.date_FROM >CONVERT(date,GETDATE())

			UNION ALL
			--ТЕКУЩИЙ АБОНЕМЕНТ
			SELECT ct.number, ct.id_tov , 0 ,ct.sp_price , null , null , MAX(ct.date_to), 0 ,0 , null , min(ct.proc_sk) , null
			FROM vv03.dbo.coupons_type2_card_tov as ct WITH(NOLOCK)
			WHERE  CONVERT(date,GETDATE()) between ct.date_FROM	AND ct.date_to 
			AND ct.date_take is not null
			GROUP BY ct.number, ct.id_tov  ,ct.sp_price

			UNION ALL

			-- на сегодня. если нет на завтра, то proc_sk из завтра
			SELECT lct.number , lct.id_tov , 0 , 0, null , null, null, lct.sp_price , 0 , lct.date_to , null ,lct.proc_sk
			FROM [vv03].[dbo].[lovepr_card_tov] as lct WITH(NOLOCK)
			WHERE lct.date_to >= CONVERT(date,getdate()) 
				 AND date_FROM <= CONVERT(date,getdate())

			UNION ALL

			-- на завтра
			SELECT lct.number , lct.id_tov , 0 , 0, null , null, null, 0, lct.sp_price , lct.date_to, null , lct.proc_sk
			FROM [vv03].[dbo].[lovepr_card_tov] as lct WITH(NOLOCK)
			WHERE lct.date_to > CONVERT(date,getdate()) AND lct.date_FROM <= dateadd(day,1,CONVERT(date,getdate()))

			) a
			INNER JOIN vv03.dbo.Tovari t WITH(NOLOCK)  on t.id_tov = a.id_tov
			WHERE a.number = @nvaCardNum
			GROUP BY a.id_tov , a.number , t.Name_tov
		
			BREAK
	end try
	begin catch
		SELECT @err_mess=ERROR_MESSAGE(),@err_num=ERROR_NUMBER()
		IF @err_num=1205 --взаимоблокировка
		BEGIN
		  SELECT @count = @count +1
		END
		ELSE
		BEGIN
			insert into jobs..error_jobs (job_name , message , number_step , id_job)
			SELECT @job_name ,	rtrim(@nvaCardNum) + ' ' + ERROR_MESSAGE() , 2 , @Id_job
			RETURN
		END  
	  
	end catch
end --while


--select * from #toFr t
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
FROM #toFr t
  INNER JOIN vv03..Tovar_full_analog as ta with(nolock)
	on t.id_tov=ta.id_tov1
  INNER JOIN vv03..Price_1C_tov as pr WITH(NOLOCK)
    ON ta.id_tov2=pr.id_tov
  LEFT JOIN #toFr as ex with(nolock)
    ON ex.number=t.number
		AND ex.id_tov=ta.id_tov2 
WHERE (t.price <> 0 OR t.LovePr_today<>0) 
		AND ex.id_tov is null        

CREATE TABLE #a (number char(7) 
			, id_tov nvarchar(max) 
			, price nvarchar(max) 
			, coup nvarchar(max) 
			, LovePr_today nvarchar(max) 
			, LovePr_tomor nvarchar(max) 
			, date_FROM date 
			, date_to date 
			, proc_sk_ab int 
			, Date_LovePr_to date 
			, proc_sk_lt int
			, [id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY)


insert into #a (number 
			, id_tov 
			, price 
			, coup  
			, LovePr_today  
			, LovePr_tomor  
			, date_FROM  
			, date_to 
			, proc_sk_ab  
			, Date_LovePr_to 
			, proc_sk_lt 
			)
SELECT a.number 
, substring(convert(nvarchar(max),a.id_tov),2,4000) id_tov
, substring(convert(nvarchar(max),a.price),2,4000) price
, substring(convert(nvarchar(max),a.coup),2,4000) coup
, substring(convert(nvarchar(max),a.LovePr_today),2,4000) LovePr_today
, substring(convert(nvarchar(max),a.LovePr_tomor),2,4000) LovePr_tomor
, tf.date_FROM
, tf.date_to
, tf.proc_sk_ab
, CASE WHEN tf2.Date_LovePr_to = {d'2000-01-01'} THEN null else tf2.Date_LovePr_to end Date_LovePr_to
, CASE WHEN  tf2.proc_sk_lt=-10 THEN null else tf2.proc_sk_lt end proc_sk_lt
FROM
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
	LEFT JOIN 
		(SELECT distinct number 
				, date_FROM 
				, date_to 
				, proc_sk_ab 
		 FROM #toFr tf 
		 WHERE date_to is not null) tf on a.number = tf.number  
	INNER JOIN 
		(SELECT number 
			, max(isnull(Date_LovePr_to,{d'2000-01-01'})) Date_LovePr_to 
			, MAX(isnull(proc_sk_lt,-10)) proc_sk_lt 
		 FROM #toFr tf 
	     GROUP BY number
	    ) tf2 on a.number = tf2.number


update [vv03].dbo.Cards_coupon with (rowlock)
set Tovari_str = a.id_tov
, Prices_str = a.price
, Cupon_str = a.coup
, LovePr_today_str = a.LovePr_today
, LovePr_tomor_str = a.LovePr_tomor
, Date_coup_FROM = a.date_FROM
, Date_coup_to = a.date_to
, Date_LovePr_to = a.Date_LovePr_to
, proc_sk_ab = a.proc_sk_ab
, proc_sk_lt = a.proc_sk_lt
--SELECT *
FROM vv03.dbo.Cards_coupon cc 
LEFT JOIN  #a a on cc.Number = a.number
WHERE 
  ( isnull(cc.Tovari_str,'') <> isnull(a.id_tov,'')
	or isnull(cc.Prices_str,'') <> isnull(a.price,'')
	or isnull(cc.Cupon_str,'') <> isnull(a.coup,'')
	or isnull(cc.LovePr_today_str,'') <> isnull(a.LovePr_today,'')
	or isnull(cc.LovePr_tomor_str,'') <> isnull(a.LovePr_tomor,'')
	or isnull(cc.Date_coup_FROM,{d'2000-01-01'}) <> isnull(a.date_FROM,{d'2000-01-01'}) 
	or isnull(cc.Date_coup_to,{d'2000-01-01'}) <> isnull(a.date_to,{d'2000-01-01'}) 
	or isnull(cc.Date_LovePr_to,{d'2000-01-01'}) <> isnull(a.Date_LovePr_to,{d'2000-01-01'}) 
	or isnull(cc.proc_sk_ab,0) <> isnull(a.proc_sk_ab,0)
	or isnull(cc.proc_sk_lt,0) <> isnull(a.proc_sk_lt,0) )
AND (cc.number = @nvaCardNum)



drop table #a

drop table #toFr


END
GO