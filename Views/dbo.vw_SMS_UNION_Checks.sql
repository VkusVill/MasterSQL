SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_SMS_UNION_Checks]
as
SELECT [CheckUID]
      ,[ShopNo]
      ,[CheckID]
      ,[ShiftID]
      ,[CashUID]
      ,[CashCheckNo]
      ,[CloseDate]
      ,[BaseSum]
      ,[Discount]
      ,[CashierUID]
      ,[Storno]
      ,[OpenDate]
      ,[BONUSCARD]
      ,[SummCash]
      ,[SummBank]
      ,[SummBonus]
      ,[OperationType]
      ,[LoadDateTime]
      ,[BONUSCARD_init]
      ,[N_terminal]
      ,[N_zakazD]
      ,[CashID]
      ,[CashierID]
      ,[FiscNo]
      ,[id_discount_ch]
      ,[discount_ch]
      ,[discount_all]
  FROM  [SRV-SQL01].[SMS_UNION].[dbo].[Checks] as ch

GO