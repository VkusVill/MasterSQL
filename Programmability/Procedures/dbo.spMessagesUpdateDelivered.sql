SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[spMessagesUpdateDelivered]
  @CashierID int,
  @CashID bigint,
  @MaxID int
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE
    Frontol.dbo.[Messages]
  SET
    Delivered = GETDATE(),
    CashID = @CashID
  WHERE Delivered IS NULL
        AND CashierID = @CashierID
        AND ID <= @MaxID
END
GO