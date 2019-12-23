SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:  	<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--select * from jobs..jobs with(nolock) where job_name like '%change_checks%'

----TESSSTTT
-- =============================================

CREATE PROCEDURE [dbo].[change_checks] @id_job int
AS
BEGIN
  SET NOCOUNT ON
  
  DECLARE
    @getdate  datetime     = GETDATE(),
    @job_name varchar(100) = com.dbo.Object_name_for_err(@@Procid, DB_ID())

END
GO