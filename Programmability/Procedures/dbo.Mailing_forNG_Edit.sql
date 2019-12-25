SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		Roda
-- Create date: 18/02/2018
-- Description: Редактирование таблицы Mailing_forNG_Edit
-- =============================================
/*
07.05.2018
ИП-00018606^01   
Для автоматической рассылки "Народный гурман" сделать ограничение по количеству отправляемых сообщений.
По умолчанию 300 с возможностью изменить в форме в 1С.
28/03/2019 по просьбе  Фельдман изменено умолчание на 150
*/

CREATE PROCEDURE [dbo].[Mailing_forNG_Edit]
	 @id_tov			int
	,@is_active			bit = 1
	,@date_deactivate	date
	,@QTY_max			int -- максимальное количество отправляемых сообщений

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if @id_tov is null or  @id_tov in (select id_tov from vv03..Mailing_forNG_except ) --запрет НГ	 
	return;
	
	if exists (select 1 from vv03.dbo.Mailing_forNG t with(nolock) where t.id_tov = @id_tov)
		update vv03.dbo.Mailing_forNG
		set  is_active = isnull(@is_active, 1)
			,date_deactivate = @date_deactivate
			,QTY_max = ISNULL(@QTY_max, QTY_max)
		where id_tov = @id_tov;
	else
	begin
		declare @date	date;
		set @date = GETDATE();
		
		insert into vv03.dbo.Mailing_forNG (id_tov, date_start, date_end, Qty_send, is_active, date_deactivate, QTY_max)
		values (@id_tov, @date, @date, 0, @is_active, @date_deactivate, ISNULL(@QTY_max, 150));
	end
	
END
GO