SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetMessages]
	@CashierID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT m.ID
		, m.MsgText Msg
		, case when m.Delivered is NULL then 1 else 0 end as NewMsg 
	FROM frontol.dbo.[Messages] m 
	WHERE CONVERT(date,m.DateTimeAdd) >= CONVERT(date,DATEADD(DAY,-3,GETDATE())) and 
		m.CashierID = @CashierID
	ORDER BY m.ID desc
	
END
GO