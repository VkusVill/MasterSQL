SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		Roda
-- Create date: 18/02/2018
-- Description:	Возвращает статус рассылки
-- =============================================
CREATE PROCEDURE [dbo].[Mailing_forNG_Stat]
	 @id_tov				int
	,@Qty_send				int		OUTPUT
	,@is_active				bit		OUTPUT
	,@date_deactivate		date	OUTPUT  
--	,@QTY_max				int		OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		 @Qty_send			= a.Qty_send
		,@is_active			= a.is_active
		,@date_deactivate	= a.date_deactivate
--		,@QTY_max			= a.QTY_max
	FROM vv03.dbo.Mailing_forNG a
	where a.id_tov = @id_tov;
END
GO