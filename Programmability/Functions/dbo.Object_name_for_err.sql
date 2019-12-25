SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		OD
-- Create date: 2018-12-05
-- Description:	Возвращает полное имя обьекта, импользуется для логирования ошибки
-- =============================================
create FUNCTION [dbo].[Object_name_for_err]
(
@proc_id		bigint,
@db_id			bigint
)
RETURNS varchar(500)
AS
BEGIN
	DECLARE @res varchar(500)
    SET  @res  = '['+ @@SERVERNAME+ ']'+'.'
								+ db_name(@db_id) + '.' 
								+ OBJECT_SCHEMA_NAME(@PROC_ID, @db_id) + '.' 
								+ OBJECT_NAME(@PROC_ID,@db_id)



	RETURN @res

END
GO