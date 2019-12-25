SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spMobileOrderHold_Insert_cashid]
  @uiGUID uniqueidentifier,
  @nvaPARAMS nvarchar(1000),
  @bitIsCardVerified bit,
  @CashIP nvarchar(20) OUTPUT,
  @nvaRemoteIP nvarchar(15)
AS
UPDATE
  MobileOrderHold
SET
  PARAMS = @nvaPARAMS,
  IsProcessed = 1,
  IsCardVerified = @bitIsCardVerified,
  RemoteIP = @nvaRemoteIP
WHERE ItemGUID = @uiGUID
      AND IsProcessed = 0

SELECT
  @CashIP = snci.CashIP
FROM [vv03].[dbo].[ShopNo_CashID] snci
INNER JOIN [Frontol]..[MobileOrderHold] mho
  ON snci.CashID = mho.CashID
WHERE mho.ItemGUID = @uiGUID
GO