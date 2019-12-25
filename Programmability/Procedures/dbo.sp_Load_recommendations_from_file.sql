SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		Shayakhmetov Rustam
-- Create date: 02.12.2019
-- Franch task number: ИП-00023281
-- Description:	Загрузка рекомендаций из файла в БД
-- =============================================
CREATE PROCEDURE [dbo].[sp_Load_recommendations_from_file] 
	@fileName nvarchar(1024)
AS
BEGIN
	SET NOCOUNT ON;

	declare @job_name varchar(500) = '[vv03].[dbo].[sp_Load_recommendations_from_file]'
	declare @id_job int = 55555

    if OBJECT_ID('tempdb..#csv') is not null drop table #csv
	create table #csv([user_id] varchar(16), product_codes varchar(max))

	Begin TRY
		begin TRAN
	
		declare @sql nvarchar(max) =
			'Bulk insert #csv
			 From ''' + @fileName + '''
			 with(
					 FIELDTERMINATOR = ''|'',
					 ROWTERMINATOR = ''0x0A'',
					 FIRSTROW = 2, -- пропускаем шапку таблицы
					 ERRORFILE = ''\\izb-dev02\Loyalty\recommendations\recommendations_load_error.csv''
				 )'

		EXEC sp_executesql @sql

		alter table #csv add RN int
		-- нумеруем строки, т.к. в файле номера "A191159" и "a191159" это разные номера и находятся в разных строках
		Update x Set x.RN = x.New_RN
		From 
		(
			Select RN, ROW_NUMBER() OVER (partition by [user_id] ORDER BY [user_id]) AS New_RN
			From #csv
		) x
		OPTION(RECOMPILE)

		Delete from [dbo].[cards_tov_predict]

		Insert into [dbo].[cards_tov_predict] (number, tov, type_ins)
		Select [user_id], [product_codes], 1
		From #csv
		Where RN = 1

		Update target set tov = tov + ',' + source.product_codes
		From [dbo].[cards_tov_predict] as target
		join #csv as source
		  on target.number = source.user_id and source.RN = 2

		commit TRAN
	End TRY
	Begin CATCH
		rollback TRAN

		Insert into jobs..error_jobs (job_name, message, id_job)
        Select @job_name, ERROR_MESSAGE() + CHAR(10) + CHAR(13) + 'Processing file: ' + @fileName, @id_job
	End CATCH

	drop table #csv
END
GO