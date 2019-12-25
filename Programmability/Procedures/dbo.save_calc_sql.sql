SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[save_calc_sql]
@id_job as int 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into  vv03..calc_sql
select --top 200
     sql = convert(nvarchar(400),substring(st.text,
                     (qs.statement_start_offset/2)+1, 
                     ((case qs.statement_end_offset when -1 then datalength(st.text) else qs.statement_end_offset end - qs.statement_start_offset)/2)+1)),
     cnt          = qs.execution_count,
     sum_duration = cast(                                    qs.total_elapsed_time/1000000/60/60     as varchar) + '°'
                  + cast(qs.total_elapsed_time/1000000/60 - (qs.total_elapsed_time/1000000/60/60)*60 as varchar) + ''''
                  + cast(qs.total_elapsed_time/1000000    - (qs.total_elapsed_time/1000000/60)*60    as varchar) + '"',
     avg_duration = qs.total_elapsed_time/qs.execution_count/1000,
     min_duration = qs.min_elapsed_time/1000,
     max_duration = qs.max_elapsed_time/1000,
     sum_CPU      = cast(                                   qs.total_worker_time/1000000/60/60     as varchar) + '°'
                  + cast(qs.total_worker_time/1000000/60 - (qs.total_worker_time/1000000/60/60)*60 as varchar) + ''''
                  + cast(qs.total_worker_time/1000000    - (qs.total_worker_time/1000000/60)*60    as varchar) + '"',
     avg_CPU      = qs.total_worker_time/qs.execution_count/1000,
     min_CPU      = qs.min_worker_time/1000,
     max_CPU      = qs.max_worker_time/1000,
     sum_reads    = qs.total_physical_reads+qs.total_logical_reads,
     min_reads    = qs.min_physical_reads+qs.min_logical_reads,
     max_reads    = qs.max_physical_reads+qs.max_logical_reads,
     query_plan   = '' , --cast(pt.query_plan as xml),
     GETDATE()
     
   from
                 sys.dm_exec_query_stats     (nolock)                 qs
     cross apply sys.dm_exec_sql_text        (qs.sql_handle)  st
     cross apply sys.dm_exec_text_query_plan (qs.plan_handle,qs.statement_start_offset,qs.statement_end_offset) pt
   --where total_worker_time 
  -- order by     qs.total_worker_time desc

END
GO