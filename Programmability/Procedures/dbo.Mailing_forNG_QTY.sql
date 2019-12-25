SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		Roda
-- Create date: 18/02/2018
-- Description:	Собираем кол-во отправлений
-- 28/03/2019 по просьбе  Фельдман изменено умолчание на 150
-- =============================================
CREATE PROCEDURE [dbo].[Mailing_forNG_QTY]
	 @id_tov			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if @id_tov is null return;
	
	declare @date	date;
	
	set @date = GETDATE();
		
	if exists (	select 1
				from vv03.dbo.Mailing_forNG as m with(nolock)
				where m.id_tov = @id_tov)
		update vv03.dbo.Mailing_forNG
			set  Qty_send = (select MAX(b.Qty_send) + 1 from vv03.dbo.Mailing_forNG as b with(nolock) where b.id_tov = @id_tov)
				,date_end = @date
		where id_tov = @id_tov
		

	else
		insert into vv03.dbo.Mailing_forNG (id_tov, date_start, date_end, Qty_send, is_active, QTY_max)
		values (@id_tov, @date, @date, 1, 1, 150);
	
	



END
GO