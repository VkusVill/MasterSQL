CREATE TABLE [dbo].[Cards] (
  [number] [nchar](7) NOT NULL CONSTRAINT [DF_Cards_number] DEFAULT (0),
  [FullName] [nvarchar](255) NOT NULL CONSTRAINT [DF_Cards_FullName] DEFAULT (''),
  [Bonus_ost] [real] NOT NULL CONSTRAINT [DF_Cards_Bonus_ost] DEFAULT (0),
  [Sales_ost] [real] NOT NULL CONSTRAINT [DF_Cards_Sales_ost] DEFAULT (0),
  [SumSales2] [int] NOT NULL CONSTRAINT [DF_Cards_SumSales2] DEFAULT (0),
  [last_date_VV] [datetime] NULL,
  [Sum_discount] [real] NULL,
  [nvaCardNum_2] [nchar](7) NULL,
  [Balance2] [int] NULL,
  [coupon_text] [nchar](50) NULL,
  [last_date_coupon] [datetime] NULL,
  [phone_card] [bigint] NULL,
  [telegram_id] [int] NULL,
  [id_bot] [int] NULL,
  [BOT_Off] [smallint] NULL,
  [DontAsk_LP] [smallint] NULL,
  [Email_Fact] [nchar](100) NULL,
  [Qty_sku] [int] NULL,
  [discount_ch] [int] NULL,
  [not_communicate] [smallint] NULL CONSTRAINT [DF_Cards_not_communicate] DEFAULT (0),
  [OneSignalToken] [varchar](40) NULL,
  [DateLP_to] [date] NULL,
  [IsEmployee] [int] NULL DEFAULT (0),
  [Shops_coupon] [varchar](100) NULL,
  [flagVirt] [bit] NULL DEFAULT (0),
  [self_service] [bit] NULL DEFAULT (0),
  [phone_prefix] [varchar](10) NULL,
  [INN] [varchar](12) NULL,
  CONSTRAINT [PK_Cards] PRIMARY KEY CLUSTERED ([number])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Cards_Date_LP_to]
  ON [dbo].[Cards] ([number], [DateLP_to])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Cards_phone]
  ON [dbo].[Cards] ([phone_card])
  INCLUDE ([number], [nvaCardNum_2])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Cards_telegram]
  ON [dbo].[Cards] ([telegram_id], [id_bot])
  INCLUDE ([number])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [du_Cards]
   ON  [dbo].[Cards]
   AFTER DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


if update([SumSales2]) 
	or update([nvaCardNum_2]) 
	or update([telegram_id]) 
	or update([Bonus_ost])
	or update (phone_card)
	or update (DateLP_to)
	or update (id_bot)
INSERT INTO [vv03].[dbo].[arc_Cards]
           ([number]
           ,[FullName]
           ,[Bonus_ost]
           ,[Sales_ost]
           ,[SumSales2]
           ,[last_date_VV]
           ,[Sum_discount]
           ,[nvaCardNum_2]
           ,[Balance2]
           ,[coupon_text]
           ,[last_date_coupon]
           ,phone_card
           ,telegram_id
           ,DateLP_to
           ,id_bot)
 select [number]
           ,[FullName]
           ,[Bonus_ost]
           ,[Sales_ost]
           ,[SumSales2]
           ,[last_date_VV]
           ,[Sum_discount]
           ,[nvaCardNum_2]
           ,[Balance2]
           ,[coupon_text]
           ,[last_date_coupon]
           ,phone_card
           ,telegram_id
           ,DateLP_to
           ,id_bot
from deleted  




END
GO