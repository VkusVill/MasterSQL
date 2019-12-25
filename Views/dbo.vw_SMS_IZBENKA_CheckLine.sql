SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

Create VIEW [dbo].[vw_SMS_IZBENKA_CheckLine]
as
SELECT  [CheckLineUID]
      ,[CheckUID]
      ,[CashCheckLineNo]
      ,[ScaleUID]
      ,[ScalePropertyUID]
      ,[ManufacturerID]
      ,[ArticleUID]
      ,[BasePrice]
      ,[Quantity]
      ,[BaseSum]
      ,[Discount]
      ,[DiscountType]
      ,[HistoryLineNo]
      ,[id_tov_cl]
      ,[id_tt_cl]
      ,[date_ch]
      ,[time_ch]
      ,[OperationType_cl]
      ,[id_nabor]
      ,[LoadDateTime_cl]
      ,[id_sms_tovar]
      ,[Confirm_reason]
      ,[id_reason]
      ,[Date_proiizv]
      ,[Qty_Other_TT]
      ,[Confirm_date]
      ,[BonusCard_cl]
  FROM  [SRV-SQL01].[SMS_IZBENKA].[dbo].[CheckLine] as cl
GO