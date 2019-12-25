SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_SMS_IZBENKA_Checks]
AS
SELECT
  [CheckUID],
  [ShopNo],
  [ShiftUID],
  [CashID],
  [CashCheckNo],
  [CloseDate],
  [BaseSum],
  [Discount],
  [Cashier],
  [BONUSCARD],
  [SummCash],
  [SummBank],
  [SummBonus],
  [OperationType],
  [JournType],
  [JournDateTime],
  [LoadDateTime],
  [HistoryLineNo],
  [OperationTypeOrig]
FROM [SRV-SQL01].SMS_IZBENKA.dbo.Checks AS ch
GO