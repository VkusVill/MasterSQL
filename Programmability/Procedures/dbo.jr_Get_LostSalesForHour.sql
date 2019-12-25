SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		Shayakhmetov Rustam
-- Create date: 04.12.2019
-- Franch task number: ИП-00017103.57
-- Description: получение информации о количестве проданных товаров на точке за каждый час за предыдущую неделю 
-- =============================================
CREATE PROCEDURE [dbo].[jr_Get_LostSalesForHour]
	@id_job as int = 34 -- первый обязательный параметр любой процедуры, запускаемой через Jobs
AS
BEGIN
	SET NOCOUNT ON;

	Begin try

		declare @dateEnd date = cast(GETDATE() - 1 as date)
		declare @datebegin date = cast(DATEADD(Week, -1, getdate()) as date)

		IF OBJECT_ID('tempdb..#ins_ls') IS NOT NULL DROP TABLE #ins_ls
		IF OBJECT_ID('tempdb..#checkLineLastWeek') IS NOT NULL DROP TABLE #checkLineLastWeek
		IF OBJECT_ID('tempdb..#tovari') IS NOT NULL DROP TABLE #tovari
		IF OBJECT_ID('tempdb..#tt') IS NOT NULL DROP TABLE #tt

		SELECT id_tov, bez_ostatkov, Ves
		  INTO #tovari
		  FROM [srv-sql01].m2.dbo.Tovari

		SELECT id_TT, tt_format, N
		  INTO #tt
		  FROM [srv-sql01].m2.dbo.tt

		SELECT date_ch
			 , DATEPART(hour, time_ch) as hour_ch
			 , id_tt_cl
			 , id_tov_cl
			 , BaseSum
			 , Quantity
			 , znak
		  INTO #checkLineLastWeek
		  FROM [srv-sql01].[SMS_UNION].[dbo].[CheckLine] WITH (NOLOCK)
		 WHERE date_ch BETWEEN @datebegin AND @dateEnd
		   and ABS(Quantity) < 20
		   and id_tt_cl IS NOT NULL
		   and id_tov_cl IS NOT NULL
		   and time_ch IS NOT NULL
		   and znak IS NOT NULL
		   and ISNULL(id_discount_chl, 0) <> 6 --продажи по зеленому ценнику

		CREATE TABLE #ins_ls 
		(
			date_ch   date,
			hour_ch   int,
			id_tt_cl  int,
			id_tov_cl int,
			sales     real,
			N         int
		)

		INSERT INTO #ins_ls 
		SELECT a.date_ch
			 , a.hour_ch
			 , a.id_tt_cl
			 , a.id_tov_cl
			 , a.sales
			 , tt.N
		FROM 
		(  
			SELECT date_ch
				 , hour_ch
				 , id_tt_cl
				 , id_tov_cl
				 , SUM(CASE WHEN BaseSum > 0 THEN Quantity * znak ELSE 0 END) AS sales
			FROM #checkLineLastWeek
			GROUP BY date_ch, hour_ch, id_tt_cl, id_tov_cl
		) as a
		join #tovari as t on  t.id_tov = a.id_tov_cl and ISNULL(t.bez_ostatkov, 0) = 0
		join #tt as tt on tt.id_TT = a.id_tt_cl

		CREATE UNIQUE CLUSTERED INDEX ind1 ON #ins_ls (id_tov_cl, id_tt_cl, date_ch, hour_ch)

		-----------------------------------------------------------------------------------------------------------------------------
		-- новое - удалить пару из полных аналогов 
		-- ищем дни, когда на 1 ТТ более 1 товара с общим id_tov_osnovn
		-- и схлопывем их в один товар, с наибольшей продажей (по весу)
		CREATE TABLE #tz
		(
			id_tov_Osnovn  int,
			id_tov_Zadvoen int,
			koef           real
		)

		INSERT INTO #tz (id_tov_Osnovn, id_tov_Zadvoen,	koef)
		SELECT t.id_tov_Osnovn,	t.id_tov_Zadvoen, t2.Ves / t1.Ves
		FROM [srv-sql01].Reports.dbo.tov_poln_zamenyaem t
		join #tovari t1 on t1.id_tov = t.id_tov_Osnovn
		join #tovari t2 on t2.id_tov = t.id_tov_Zadvoen

		CREATE UNIQUE CLUSTERED INDEX ind1 ON #tz (id_tov_Zadvoen)

		IF OBJECT_ID('tempdb..#zadv_tov') IS NOT NULL DROP TABLE #zadv_tov

		CREATE TABLE #zadv_tov
		(
			date_ch   date,
			hour_ch   int,
			id_tt_cl  int,
			id_tov    int,
			id_tov_cl int,
			q         real,
			koef      real
		)

		INSERT INTO #zadv_tov
		(
			date_ch,
			hour_ch,
			id_tt_cl,
			id_tov,
			id_tov_cl,
			q,
			koef
		)
		SELECT
			date_ch,
			hour_ch,
			id_tt_cl,
			id_tov,
			id_tov_cl,
			q,
			koef
		FROM 
		( 
			SELECT i.date_ch
				 , i.hour_ch
				 , i.id_tt_cl
				 , ISNULL(tz.id_tov_Osnovn, i.id_tov_cl) id_tov
				 , i.id_tov_cl
				 , i.sales / ISNULL(tz.koef, 1) q
				 , tz.koef
				 , ROW_NUMBER()
					OVER (PARTITION BY i.date_ch, i.hour_ch, i.id_tt_cl, ISNULL(tz.id_tov_Osnovn, i.id_tov_cl)
						  ORDER BY i.sales/ISNULL(tz.koef, 1) DESC, tz.koef)
				   AS rn
			FROM #ins_ls AS i
			LEFT JOIN #tz AS tz on i.id_tov_cl = tz.id_tov_Zadvoen
		) AS a
		WHERE a.rn > 1

		-- удаление
		DELETE FROM i
		  FROM #ins_ls AS i
		  join #zadv_tov z
			on i.date_ch = z.date_ch
		   and i.hour_ch = z.hour_ch
		   and i.id_tt_cl = z.id_tt_cl
		   and i.id_tov_cl = z.id_tov_cl

		-- добавить удаленные товары из задвоений
		UPDATE #ins_ls SET sales = i2.sales + z.q * ISNULL(i.koef, 1)
		FROM #ins_ls i2
		join
		( 
			SELECT i.date_ch
				 , i.hour_ch
				 , i.id_tt_cl
				 , ISNULL(tz.id_tov_Osnovn, i.id_tov_cl) id_tov
				 , i.id_tov_cl
				 , tz.koef
			FROM #ins_ls i
			left join #tz tz ON i.id_tov_cl = tz.id_tov_Zadvoen
		) AS i
			on i.date_ch = i2.date_ch
		   and i.hour_ch = i2.hour_ch
		   and i.id_tt_cl = i2.id_tt_cl
		   and i.id_tov_cl = i2.id_tov_cl
		join 
		( 
			SELECT z.date_ch
				 , z.hour_ch
				 , z.id_tt_cl
				 , z.id_tov
				 , SUM(z.q) q
			FROM #zadv_tov z
			GROUP BY z.date_ch, z.hour_ch, z.id_tt_cl, z.id_tov
		) z
			on i.date_ch = z.date_ch
		   and i.hour_ch = z.hour_ch
		   and i.id_tt_cl = z.id_tt_cl
		   and i.id_tov = z.id_tov

		DROP TABLE #zadv_tov
		-----------------------------------------------------------------------------------------------------------------------------
		truncate table [vv03].[dbo].[Lost_sales_hour]

		INSERT INTO [vv03].[dbo].[Lost_sales_hour]
		(
			date_ls,
			hour_ls,
			id_tt_ls,
			id_tov_ls,
			shopno_ls,
			sales_fact
		)
		SELECT
			date_ch,
			hour_ch,
			id_tt_cl,
			id_tov_cl,
			N,
			sales
		FROM #ins_ls

	End TRY
	Begin CATCH
		INSERT INTO jobs.dbo.error_jobs (job_name, message, number_step, id_job)
		SELECT 'vv03.dbo.jr_Get_LostSalesForHour', ERROR_MESSAGE(), 10000, @id_job
	End CATCH

END
GO