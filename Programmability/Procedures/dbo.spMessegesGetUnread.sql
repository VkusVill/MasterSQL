SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spMessegesGetUnread]
	@CashierID int
	,@Qnt int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @id_job as int=10000
		,@job_name as varchar(100)='frontol.dbo.spMessegesGetUnread'	
begin try
	
	SELECT @Qnt = COUNT(ID)
	FROM frontol.dbo.[Messages] m (NOLOCK)
	WHERE CashierID = @CashierID and Delivered is NULL
end try
begin catch
  insert jobs..error_jobs(id_job, job_name, date_add, number_step, message)
  select @id_job, @job_name, GETDATE(), 100, error_message()
end catch
END
GO