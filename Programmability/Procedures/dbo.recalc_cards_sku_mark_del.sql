SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2017-09-07
-- Description:	список  оцененных товаров с начала месяца
-- =============================================
CREATE PROCEDURE [dbo].[recalc_cards_sku_mark_del] 
	-- Add the parameters for the stored procedure here
@id_job as int=-2000
,@number as char(7)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


declare @getdate as datetime =getdate()


insert into jobs..Jobs_log ([id_job],[number_step],[duration], par4) 
select @id_job ,10, DATEDIFF(MILLISECOND , @getdate ,GETDATE()) , @number
select @getdate = getdate() 



if OBJECT_ID('tempdb..#cards_sku_mark') is not null drop table #cards_sku_mark


begin try
		--declare @id_job as int =-2000,@number char(7) -- = '0001757'


		if @number is not null and  LEN(@number)<7
		 select @number = replace(space(7-LEN(@number)),' ','0') + RTRIM(@number)

		create table #cards_sku_mark (number char(7), telegram_id int ,[sku_month_mark] varchar(max))

		if @number is null
		insert into #cards_sku_mark(number, telegram_id)
		select c.Number, c.telegram_id
		from vv03..cards as c with(nolock)
		where isnull(c.telegram_id,0)<>0
		else
		insert into #cards_sku_mark(number, telegram_id)
		select c.Number, c.telegram_id
		from vv03..cards as c with(nolock)
		where number=@number

		create index ind_cards_sku_mark on #cards_sku_mark (number) 
		

		select distinct c.number,id_tov 
		into #tov_mark
		from loyalty..BOT_Purchase_Tovar_Reiting as r with(nolock)
			inner join #cards_sku_mark as c with(nolock) on r.telegram_id=c.telegram_id
		where r.date_add>=convert(date,dateadd(day,1-datepart(day,getdate()),getdate())) and date_ch>=convert(date,dateadd(day,1-datepart(day,getdate()),getdate()))

		--select * from #cards_sku_mark

		create clustered index ind1 on #tov_mark (number, id_tov)



		update #cards_sku_mark set [sku_month_mark]=res.[sku_month_mark]
		from #cards_sku_mark as c 
			inner join (select distinct m.number
							, SUBSTRING((select',' + RTRIM(id_tov) 
								from  #tov_mark v1 where v1.number=m.number for XML path('') ),2,1000) [sku_month_mark]
							from #tov_mark m) res on c.number=res.number



		drop table #tov_mark
		
		update   vv03..Cards_tov_tt with(rowlock) set sku_month_mark=ISNULL(csm.sku_month_mark,'')
		--select * 
		from  vv03..Cards_tov_tt as c 
			inner join  #cards_sku_mark csm on c.number=csm.number
		where isnull(c.sku_month_mark,'') <>ISNULL(csm.sku_month_mark,'')
		
		insert into vv03.dbo.Cards_tov_tt (number, sku_month_mark )
		select 	a.number,a.sku_month_mark
		FROM vv03.dbo.Cards_tov_tt c right join #cards_sku_mark a 
					 on c.number=a.number
		where c.number is null  	  
		
		--declare @id_job as int =-2000,@number char(7) -- = '0001757'

		declare @s nvarchar(4000)

		set @s='update vv03.dbo.Cards_tov_tt with(rowlock) set sku_month_mark=null
		FROM vv03..Cards_tov_tt c left join #cards_sku_mark a 
			 on c.number=a.number
		where a.number is null ' + case when @number is null then '' else ' and c.number= '''+RTRIM(@number)+''' ' end
								+'	and  isnull(c.sku_month_mark,'''')<>'''''
		--print @s
		exec sp_executesql @s
								
		if OBJECT_ID('tempdb..#cards_sku_mark') is not null drop table #cards_sku_mark



end try
begin catch
  insert into jobs..error_jobs(job_name, number_step, message)
  select 'vv03..recalc_cards_coupon_all', 10, ERROR_MESSAGE()
  if OBJECT_ID('tempdb..#cards_sku_mark') is not null drop table #cards_sku_mark
end catch
END
GO